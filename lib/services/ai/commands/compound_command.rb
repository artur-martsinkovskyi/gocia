# frozen_string_literal: true

module Ai
  module Commands
    class CompoundCommand
      attr_reader :commands

      def initialize(*commands)
        @commands = commands
      end

      def call
        commands.each(&:call)
      end
    end
  end
end
