# frozen_string_literal: true

module Controls
  module Commands
    class MouseMoveCursorCommand < Command
      attribute :cursor, Types.Instance(Cursor)

      def call(x, y)
        cursor.move_to(x, y)
      end
    end
  end
end
