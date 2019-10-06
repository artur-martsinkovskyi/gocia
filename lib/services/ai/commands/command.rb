# frozen_string_literal: true

module Ai
  module Commands
    class Command
      attr_reader :actor, :metadata

      def initialize(actor, metadata = {})
        @actor = actor
        @metadata = metadata
      end
    end
  end
end
