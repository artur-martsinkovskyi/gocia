# frozen_string_literal: true

require_relative 'util/ostructify'
require_relative 'util/types'

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
          root.join('config', 'base.yml')
        )
      ).to_frozen_ostruct
    end
  end
end
