# frozen_string_literal: true

module AI
  class DieCommand
    attr_reader :actor, :metadata

    def initialize(actor, metadata = {})
      @actor = actor
      @metadata = metadata
    end

    def call
      @actor.stats.alive = false
    end

    def redo
      call
    end

    def undo
      @actor.stats.alive = true
    end
  end
end
