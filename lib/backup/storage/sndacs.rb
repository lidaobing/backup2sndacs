require 'backup/logger'
require 'sndacs'

module Backup
  module Storage
    class Sndacs < Base

      attr_accessor :access_key, :access_secret
      attr_accessor :bucket
      attr_accessor :path

      def initialize(model, storage_id = nil, &block)
        super(model, storage_id)

        @bucket ||= 'backups'

        instance_eval(&block) if block_given?
      end

      def remove!(pkg)
        remote_path = remote_path_for(pkg)
        package.filenames.each do |remote_file|
          Logger.info "#{storage_name} started removing " +
              "'#{ remote_file }' from bucket '#{ bucket }'."
          key = File.join(remote_path, remote_file)
          res = bucket_service.objects.find(key).destroy
          unless res == true
            raise "delete '#{key}' failed"
          end
        end
      end

      def transfer!
        remote_path = remote_path_for(@package)
        package.filenames.each do |filename|
          Logger.info "#{storage_name} started transferring " +
              "'#{ filename }'."
          key = File.join(remote_path, filename)
          o = bucket_service.objects.build(key)
          o.content = open(File.join(Config.tmp_path, filename))
          res = o.save
          raise "upload '#{filename}' failed" unless res == true
          Logger.info "file uploaded to bucket:#{bucket}, key:#{key}"
        end
      end

      private
      def bucket_service
        @bucket_service ||= begin
          service = ::Sndacs::Service.new(:access_key_id => @access_key, :secret_access_key => @access_secret)
          service.buckets.find(@bucket)
        end
      end
    end
  end
end
