require 'backup/logger'
require 'sndacs'

module Backup
  module Storage
    class Sndacs < Base

      attr_accessor :access_key, :access_secret
      attr_accessor :bucket

      def initialize(model, storage_id = nil, &block)
        super(model, storage_id)

        @bucket ||= 'backups'

        instance_eval(&block) if block_given?
      end

      def path
        ''
      end

      def remove!(pkg)
        # TODO
      end

      def transfer!
        remote_path = remote_path_for(@package)
        files_to_transfer_for(@package) do |local_file, remote_file|
          Logger.message "#{storage_name} started transferring " +
              "'#{ local_file }'."
          key = File.join(remote_path, remote_file)
          o = bucket_service.objects.build(key)
          o.content = open(File.join(local_path, local_file))
          res = o.save
          raise "upload '#{local_file}' failed" unless res == true
          Logger.message "file uploaded to bucket:#{bucket}, key:#{key}"
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
