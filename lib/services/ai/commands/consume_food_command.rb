# frozen_string_literal: true

module Ai
  module Commands
    class ConsumeFoodCommand < Command
      def call
        food = metadata[:food]

        actor.update do |actor|
          if food.poisonous?
            actor.stats.hunger.inc
            actor.stats.health.dec(2)
          else
            actor.stats.hunger.dec(4)
            actor.stats.health.inc(2)
          end
        end
      end
    end
  end
end
