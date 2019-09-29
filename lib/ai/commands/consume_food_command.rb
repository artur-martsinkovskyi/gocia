# frozen_string_literal: true

module AI
  class ConsumeFoodCommand
    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def call
      @food = metadata.delete(:food)
      @previous_hunger = actor.stats.hunger
      @previous_health = actor.stats.health

      if @food.poisonous?
        actor.stats.hunger.inc
        actor.stats.health.dec(2)
      else
        actor.stats.hunger.dec(4)
        actor.stats.health.inc(2)
      end
    end

    def redo
      call
    end

    def undo
      metadata[:food] = @food
      @actor.stats.hunger.set(@previous_hunger.value)
      @actor.stats.health.set(@previous_health.value)
    end
  end
end
