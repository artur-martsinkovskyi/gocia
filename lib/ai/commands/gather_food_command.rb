# frozen_string_literal: true

module AI
  class GatherFoodCommand
    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def call
      slate = surrounding_slates.detect do |slate|
        slate.contents.any? do |content|
          content.is_a?(Tree) && content.fruit
        end
      end

      return unless slate

      @tree = slate.contents.detect do |content|
        content.is_a?(Tree) && content.fruit
      end

      @fruit = @tree.fruit
      @tree.fruit = nil
      actor.consume(@fruit)
    end

    def redo
      call
    end

    def undo
      return unless @tree

      @tree.fruit = @fruit
      actor.deconsume(@fruit)
    end

    private

    def surrounding_slates
      actor.slate.surrounding_slates
    end
  end
end
