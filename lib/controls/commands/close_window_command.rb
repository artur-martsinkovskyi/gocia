module Controls
  class CloseWindowCommand
    attr_reader :window

    def initialize(window)
      @window = window
    end

    def call
      window.close
    end
  end
end
