# frozen_string_literal: true

module Controls
  module Commands
    class SoundCommand < Command
      attribute :engine, Types.Instance(SoundEngine)

      def call
        if engine.song.playing?
          engine.song.pause
        else
          engine.song.play
        end
      end
    end
  end
end
