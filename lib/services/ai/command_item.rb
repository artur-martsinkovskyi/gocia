# frozen_string_literal: true

module Ai
  class CommandItem
    attr_reader :command, :tick

    def initialize(command:, tick:)
      @command = command
      @tick = tick
    end

    def <=>(other)
      tick <=> other.tick
    end
  end
end
