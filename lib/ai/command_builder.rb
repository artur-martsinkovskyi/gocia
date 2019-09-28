# frozen_string_literal: true

module AI
  class CommandBuilder
    attr_reader :emitter

    def initialize(emitter)
      @emitter = emitter
    end

    def step
      CompoundCommand.new(
        MoveCommand.new(actor, metadata),
        GatherFoodCommand.new(actor, metadata)
      )
    end

    def metadata
      @metadata ||= {}
    end

    private

    def commands
      emitter.commands
    end

    def actor
      emitter.actor
    end
  end
end
