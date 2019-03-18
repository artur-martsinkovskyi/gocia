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
      return SAME if slate1.x == slate2.x && slate1.y == slate2.y

      if slate1.x == slate2.x
        if slate1.y > slate2.y
          SOUTH
        else
          NORTH
        end
      elsif slate1.y == slate2.y
        if slate1.x > slate2.x
          EAST
        else
          WEST
        end
      else
        if slate1.x > slate2.x
          if slate1.y > slate2.y
            SOUTH_EAST
          else
            SOUTH_WEST
          end
        else
          if slate1.y < slate2.y
            NORTH_EAST
          else
            NORTH_WEST
          end
        end
      end
    end
  end
end
