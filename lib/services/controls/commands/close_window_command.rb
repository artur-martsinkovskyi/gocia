# frozen_string_literal: true

module Controls
  module Commands
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
end
