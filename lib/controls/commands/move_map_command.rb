# frozen_string_literal: true

module Controls
  class MoveMapCommand
    attr_reader :map
    DIRECTIONS = {
      Gosu::KB_A => :left,
      Gosu::KB_D => :right,
      Gosu::KB_W => :up,
      Gosu::KB_S => :down
    }.freeze

    def initialize(map)
      @map = map
    end

    def call(id)
      map.move(DIRECTIONS[id])
    end
  end
end
