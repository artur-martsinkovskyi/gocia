# frozen_string_literal: true

module Controls
  module Commands
    class MoveCursorCommand < Command
      attribute :cursor, Types.Instance(Cursor)

      DIRECTIONS = {
        Gosu::KB_LEFT => :left,
        Gosu::KB_RIGHT => :right,
        Gosu::KB_UP => :up,
        Gosu::KB_DOWN => :down
      }.freeze

      def call(id)
        cursor.move(DIRECTIONS[id])
      end
    end
  end
end
