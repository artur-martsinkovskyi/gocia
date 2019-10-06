# frozen_string_literal: true

module Controls
  class ButtonUpMapper
    extend Dry::Initializer
    param :context, Types.Instance(Window)

    def trigger(signal:)
      case signal
      when Gosu::KB_LEFT, Gosu::KB_RIGHT, Gosu::KB_UP, Gosu::KB_DOWN
        move_cursor_command.call(signal)
      when Gosu::KB_W, Gosu::KB_S, Gosu::KB_A, Gosu::KB_D
        move_map_command.call(signal)
      end
    end

    private

    def move_cursor_command
      @move_cursor_command ||= Commands::MoveCursorCommand.new(cursor: context.cursor)
    end

    def move_map_command
      @move_map_command ||= Commands::MoveMapCommand.new(map: context.map)
    end
  end
end
