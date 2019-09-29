# frozen_string_literal: true

module AI
  class EmptyCommand
    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def call; end

    def redo
      call
    end

    def undo; end
  end
end
