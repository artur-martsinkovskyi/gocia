class SoundEngine
  attr_reader :song
  SONG_PATH = Gocia.root.join('assets', 'audio', '8beethoven.mp3').freeze

  def initialize
    @song = Gosu::Song.new(SONG_PATH)
  end

  def command
    @command ||= Controls::SoundCommand.new(self)
  end
end

