# frozen_string_literal: true

module Actors
  class Initializer
    def initialize(world)
      @world = world
    end

    def call
      placements = Array.new(5) { [0, 0] }

      placements.map do |x, y|
        slate = world.slates[x][y]
        actor = Actor.new(world, slate)
        actor
      end
    end

    private

    attr_reader :world
  end
end
