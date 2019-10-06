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
        actor.update do |actor|
          actor.stats.hunger.inc
          actor.stats.health.dec if actor.stats.hunger.value == actor.stats.hunger.upper_bound
          actor.slate = @next_slate
        end
        @previous_slate.update { |slate| slate.contents.delete(actor) }
        @next_slate.update { |to| to.contents.push(actor) }
      end

      private

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
