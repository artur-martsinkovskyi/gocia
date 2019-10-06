# frozen_string_literal: true

module Ai
  module Commands
    class GatherFoodCommand < Command
      include SlatesRuleset

      def call
        food_slate = surrounding_slates.find do |slate|
          slate.contents.any?(&satisfies?(IsTreeWithFruit))
        end

        return unless food_slate

        tree = food_slate.contents.find(&satisfies?(IsTreeWithFruit))

        fruit = tree.fruit
        tree.update { |fruitful_tree| fruitful_tree.fruit = nil }
        ConsumeFoodCommand.new(actor, metadata.merge(food: fruit)).call
      end

      private

      def surrounding_slates
        actor.slate.surrounding_slates
      end
    end
  end
end
