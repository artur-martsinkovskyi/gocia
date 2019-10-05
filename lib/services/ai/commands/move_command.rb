# frozen_string_literal: true

module Ai
  module Commands
    class MoveCommand < Command
      extend Dimensions
      def call
        unless @next_slate
          @previous_slate = actor.slate
          @next_slate = pick_slate
        end
        @previous_health = actor.stats.health.value
        @previous_hunger = actor.stats.hunger.value
        actor.stats.hunger.inc
        actor.stats.health.dec if actor.stats.hunger.value == actor.stats.hunger.upper_bound
        move(to: @next_slate)
      end

      def redo
        call
      end

      def undo
        move(to: @previous_slate)
        actor.stats.health.set(@previous_health)
        actor.stats.hunger.set(@previous_hunger)
      end

      private

      def move(to:)
        actor.slate.contents.delete(actor)
        to.contents.push(actor)
        actor.slate = to
      end

      def pick_slate
        slates = actor.slate.surrounding_slates

        if metadata[:direction]
          next_slate = slates[metadata[:direction]]
          if next_slate && rand(10) < 9
            next_slate
          else
            metadata[:direction] = nil
            slates.compact.sample
          end
        else
          slate = slates.compact.sample
          metadata[:direction] = Displacement::DirectionDetector.new(@previous_slate, slate).call
          slate
        end
      end
    end
  end
end
