module Actors
  class Initializer
    def initialize(world)
      @world = world
    end

    def call
      placements = [[0, 0], [1, 1]]
      placements.map do |x, y|
        slate = world.slates[x][y]
        actor = Actor.new(world)
        actor.slate = slate
        slate.contents.add(actor)
        actor
      end
    end

    private

    attr_reader :world
  end
end
