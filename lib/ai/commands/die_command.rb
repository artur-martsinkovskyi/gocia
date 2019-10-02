# frozen_string_literal: true

module AI
  class DieCommand < Command
    def call
      actor.update do |actor|
        actor.stats.alive = false
      end
    end

    def redo
      call
    end

    def undo
      actor.rollback
    end
  end
end
