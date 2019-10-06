# frozen_string_literal: true

module Controls
  module Commands
    class CloseWindowCommand < Command
      attribute :window, Types::Instance(Window)

      def call
        window.close
      end
    end
  end
end
