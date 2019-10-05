# frozen_string_literal: true

module Controls
  module Commands
    class MoveCursorCommand
      attr_reader :cursor
      DIRECTIONS = {
        Gosu::KB_LEFT => :left,
        Gosu::KB_RIGHT => :right,
        Gosu::KB_UP => :up,
        Gosu::KB_DOWN => :down
      }.freeze

      def initialize(cursor)
        @cursor = cursor
      end

      def call(id)
        cursor.move(DIRECTIONS[id])
      end
    end
  end
end
