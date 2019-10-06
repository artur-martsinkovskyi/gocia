# frozen_string_literal: true

module Controls
  module Commands
    class MoveMapCommand < Command
      attribute :map, Types.Instance(Map)

      DIRECTIONS = {
        Gosu::KB_A => :left,
        Gosu::KB_D => :right,
        Gosu::KB_W => :up,
        Gosu::KB_S => :down
      }.freeze

      def call(id)
        map.move(DIRECTIONS[id])
      end
    end
  end
end
