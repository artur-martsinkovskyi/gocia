# frozen_string_literal: true

module AI
  class DieCommand < Command
    def call
      actor.stats.alive = false
    end

    def redo
      call
    end

    def undo
      actor.stats.alive = true
    end
  end
end
