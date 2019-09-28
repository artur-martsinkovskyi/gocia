# frozen_string_literal: true

module Displacement
  class DirectionDetector
    NORTH = 2
    SOUTH = 8
    WEST  = 4
    EAST  = 6
    NORTH_WEST = 1
    NORTH_EAST = 3
    SOUTH_WEST = 7
    SOUTH_EAST = 9
    SAME = 5

    DIRECTIONS = [
      NORTH,
      SOUTH,
      WEST,
      EAST,
      NORTH_WEST,
      NORTH_EAST,
      SOUTH_WEST,
      SOUTH_EAST
    ].freeze

    attr_reader :slate1, :slate2

    def initialize(slate1, slate2)
      @slate1 = slate1
      @slate2 = slate2
    end

    def call
      return SAME if same?

      return (slate1.y > slate2.y ? EAST : WEST) if same_by_x?

      return (slate1.x > slate2.x ? SOUTH : NORTH) if same_by_y?

      return (slate1.y > slate2.y ? SOUTH_EAST : SOUTH_WEST) if down_by_x?

      slate1.y < slate2.y ? NORTH_EAST : NORTH_WEST
    end

    private

    def same?
      same_by_x? && same_by_y?
    end

    def same_by_x?
      slate1.x == slate2.x
    end

    def same_by_y?
      slate1.y == slate2.y
    end

    def down_by_x?
      slate1.x > slate2.x
    end
  end
end
