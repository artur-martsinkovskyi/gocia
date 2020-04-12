# frozen_string_literal: true

module Ai
  module Commands
    class MoveCommand < Command
      def call
        previous_slate = actor.slate
        next_slate = pick_slate
        actor.update do |actor|
          actor.stats.hunger.inc
          actor.stats.health.dec if actor.stats.hunger.value == actor.stats.hunger.upper_bound
          actor.slate = next_slate
        end
        previous_slate.update { |slate| slate.contents.delete(actor) }
        next_slate.update { |slate| slate.contents.push(actor) }
      end

      private

      memoize def pick_slate
        slates = actor.slate.surrounding_slates.select do |slate|
          slate.biome.land?
        end

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
          metadata[:direction] = Displacement::DirectionDetector.new(actor.slate, slate).call
          slate
        end
      end
    end
  end
end
