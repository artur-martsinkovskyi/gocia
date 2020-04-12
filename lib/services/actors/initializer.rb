# frozen_string_literal: true

module Actors
  class Initializer < Operation
    attribute :world, Types.Instance(World)

    def call
      placements = Array.new(
        Gocia.config.world.actors.count
      ) do
        [
          Gocia.config.world.actors.starting_point.x,
          Gocia.config.world.actors.starting_point.y,
        ]
      end

      placements.map do |x, y|
        slate = world.slates[x][y]
        Actor.new(slate_id: slate.object_id)
      end
    end
  end
end
