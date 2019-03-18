# frozen_string_literal: true

module Gocia
  APPLICATION_NAME = 'Socia'

  class << self
    def root
      @root ||= Pathname.new(File.join(File.split(__dir__)[0..-2]))
    end
  end
end
