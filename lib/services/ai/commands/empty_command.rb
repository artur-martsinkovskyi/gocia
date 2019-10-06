# frozen_string_literal: true

module Ai
  module Commands
    class EmptyCommand
      attr_reader :actor, :metadata

      def initialize(actor, metadata = {})
        @actor = actor
        @metadata = metadata
      end

      def call; end
    end
  end
end
