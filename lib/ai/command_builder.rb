# frozen_string_literal: true

module AI
  class CommandBuilder
    attr_reader :emitter

    def initialize(emitter)
      @emitter = emitter
    end

    def step
      if !actor.stats.alive
        EmptyCommand.new(actor, metadata)
      elsif actor.stats.health.value == actor.stats.health.lower_bound
        DieCommand.new(actor, metadata)
      else
        CompoundCommand.new(
          MoveCommand.new(actor, metadata),
          GatherFoodCommand.new(actor, metadata)
        )
      end
    end

    def metadata
      @metadata ||= {}
    end

    private

    def actor
      emitter.actor
    end
  end
end
