module Controls
  class ButtonDownMapper
    attr_reader :context

    def initialize(context)
      @context = context
    end

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
      else
        empty_command.call
      end
    end

    private

    def sound_command
      @sound_command ||= SoundCommand.new(context.sound_engine)
    end

    def close_window_command
      @close_window_command ||= CloseWindowCommand.new(context)
    end

    def mouse_move_cursor_command
      @mouse_move_cursor_command ||= MouseMoveCursorCommand.new(context.cursor)
    end

    def empty_command
      @empty_command ||= -> {}
    end
  end
end
