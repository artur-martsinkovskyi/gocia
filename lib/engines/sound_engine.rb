# frozen_string_literal: true

class SoundEngine
  extend Memoist
  attr_reader :song
  SONG_PATH = Gocia.root.join('assets', 'audio', '8beethoven.mp3').freeze

  def initialize
    @song = Gosu::Song.new(SONG_PATH)
  end

  memoize def command
    Controls::SoundCommand.new(engine: self)
  end
end
