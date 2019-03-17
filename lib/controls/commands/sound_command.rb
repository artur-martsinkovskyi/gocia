module Controls
  class SoundCommand
    attr_reader :engine

    def initialize(engine)
      @engine = engine
    end

    def call
      if engine.song.playing?
        engine.song.pause
      else
        engine.song.play
      end
    end
  end
end
