# frozen_string_literal: true

module AI
  class Command
    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def redo
      call
    end
  end
end
