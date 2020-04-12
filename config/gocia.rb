# frozen_string_literal: true

require 'yaml'

module Gocia
  APPLICATION_NAME = 'Socia'
  using Ostructify

  class << self
    def root
      @root ||= Pathname.new(File.join(File.split(__dir__)[0..-2]))
    end

    def config
      @config ||= YAML.safe_load(
        File.read(
          root.join('config', $config_path || 'base.yml')
        )
      ).to_frozen_ostruct
    end
  end
end
