# frozen_string_literal: true

module Controls
  class ButtonDownMapper
    extend Dry::Initializer
    param :context, Types.Instance(Window)

    def trigger(signal:)
      case signal
      when Gosu::KB_M
        sound_command.call
      when Gosu::KB_ESCAPE
        close_window_command.call
      when Gosu::MsLeft
        mouse_move_cursor_command.call(
          context.mouse_x,
          context.mouse_y
        )
      end
    end

    private

    def sound_command
      @sound_command ||= Commands::SoundCommand.new(engine: context.sound_engine)
    end

    def close_window_command
      @close_window_command ||= Commands::CloseWindowCommand.new(window: context)
    end

    def mouse_move_cursor_command
      @mouse_move_cursor_command ||= Commands::MouseMoveCursorCommand.new(cursor: context.cursor)
    end
  end
end
