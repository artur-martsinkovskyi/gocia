# frozen_string_literal: true

module AI
  class CompoundCommand
    attr_reader :commands

    def initialize(*commands)
      @commands = commands
    end

    def call
      commands.each(&:call)
    end

    def redo
      call
    end

    def undo
      commands.each(&:undo)
    end
  end
end
