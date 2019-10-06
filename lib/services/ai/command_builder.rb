# frozen_string_literal: true

module Ai
  class CommandBuilder
    attr_reader :emitter

    def initialize(emitter)
      @emitter = emitter
    end

    def build
      if !actor.stats.alive
        Commands::EmptyCommand.new(actor, metadata)
      elsif actor.stats.health.value == actor.stats.health.lower_bound
        Commands::DieCommand.new(actor, metadata)
      else
        Commands::CompoundCommand.new(
          Commands::MoveCommand.new(actor, metadata),
          Commands::GatherFoodCommand.new(actor, metadata)
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
