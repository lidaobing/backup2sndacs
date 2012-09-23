require 'backup/config/sndacs'
require "backup2sndacs/version"

module Backup2sndacs
end

module Backup
  module Storage
    autoload :Sndacs, 'backup/storage/sndacs'
  end
end
