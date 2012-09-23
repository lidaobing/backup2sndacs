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
        establish_connection!
        remote_path = remote_path_for(@package)
        files_to_transfer_for(@package) do |local_file, remote_file|
          Logger.message "#{storage_name} started transferring " +
              "'#{ local_file }'."
          # TODO
          raise "upload '#{local_file}' failed"
          Logger.message "file uploaded to bucket:#{bucket}, key:#{key}"
        end
      end

      private
      def establish_connection!
        # TODO
      end
    end
  end
end
