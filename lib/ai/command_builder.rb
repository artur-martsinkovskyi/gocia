# frozen_string_literal: true

module AI
  class CommandBuilder
    attr_reader :actor

    def initialize(actor)
      @actor = actor
    end

    def step
      MoveCommand.new(actor, metadata)
    end

    def metadata
      @metadata ||= {}
    end
  end
end
