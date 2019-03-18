# frozen_string_literal: true

require_relative '../../constants/dimensions'

module AI
  class MoveCommand
    include Dimensions

    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def call
      @previous_slate = actor.slate
      slates = surrounding_slates(actor.slate)
      slate = if metadata[:direction]
                next_slate = slates[metadata[:direction]]
                if next_slate && rand(10) < 9
                  next_slate
                else
                  metadata[:direction] = nil
                  slates.compact.sample
                end
              else
                next_slate = slates.compact.sample
                metadata[:direction] = Displacement::DirectionDetector.new(@previous_slate, next_slate).call
                next_slate
              end
      change_slate(slate)
      actor
    end

    def redo
      call
    end

    def undo
      change_slate(@previous_slate)
      @previous_slate = nil
      actor
    end

    private

    def change_slate(slate)
      actor.slate.contents.delete(actor)
      actor.slate = slate
      slate.contents.add(actor)
    end

    def surrounding_slates(slate)
      x, y = slate.x, slate.y
      [x - 1, x, x + 1].map do |xx|
        [y - 1, y, y + 1].map do |yy|
          next if yy.negative? || yy >= TILE_COUNT
          next if xx.negative? || xx >= TILE_COUNT

          slate = actor.world.slates[xx][yy]
          next if slate.biome.water?

          slate
        end
      end.flatten
    end
  end
end
