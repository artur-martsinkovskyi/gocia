# frozen_string_literal: true

module Ai
  module Commands
    class GatherFoodCommand
      attr_reader :actor, :metadata

      include SlatesRuleset

      def initialize(actor, metadata = {})
        @actor = actor
        @metadata = metadata
      end

      def call
        food_slate = surrounding_slates.find do |slate|
          slate.contents.any?(&satisfies?(IsTreeWithFruit))
        end

        return unless food_slate

        @tree = food_slate.contents.find(&satisfies?(IsTreeWithFruit))

        @fruit = @tree.fruit
        @tree.fruit_id = nil
        @command = ConsumeFoodCommand.new(@actor, food: @fruit)
        @command.call
      end

      def redo
        call
      end

      def undo
        return unless @tree

        @command.undo
        @tree.fruit = @fruit
      end

      private

      def surrounding_slates
        actor.slate.surrounding_slates
      end
    end
  end
end
