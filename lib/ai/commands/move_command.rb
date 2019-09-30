# frozen_string_literal: true

require_relative '../../constants/dimensions'

module AI
  class MoveCommand < Command
    extend Dimensions
    def call
      unless @next_slate
        @previous_slate = actor.slate
        @next_slate = pick_slate
      end
      actor.move(to: @next_slate)
    end

    def redo
      call
    end

    def undo
      actor.move(to: @previous_slate)
    end

    private

    def pick_slate
      slates = actor.slate.surrounding_slates

      if metadata[:direction]
        next_slate = slates[metadata[:direction]]
        if next_slate && rand(10) < 9
          next_slate
        else
          metadata[:direction] = nil
          slates.compact.sample
        end
      else
        slate = slates.compact.sample
        metadata[:direction] = Displacement::DirectionDetector.new(@previous_slate, slate).call
        slate
      end
    end
  end
end
