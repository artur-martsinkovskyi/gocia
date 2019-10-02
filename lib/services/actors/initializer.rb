# frozen_string_literal: true

module Actors
  class Initializer
    def initialize(world)
      @world = world
    end

    def call
      placements = Array.new(
        Gocia.config.world.actor_count
      ) { [0, 34] }

      placements.map do |x, y|
        slate = world.slates[x][y]
        actor = Actor.new(world: world, slate_id: slate.object_id)
        actor
      end
    end

    private

    attr_reader :world
  end
end
