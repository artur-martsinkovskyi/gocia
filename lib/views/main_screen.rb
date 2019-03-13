require 'rmagick'

class MainScreen < Gosu::Window
  include Dimensions
  include WithLoadscreen

  attr_reader :sound_engine,
    :world_engine,
    :map,
    :cursor

  def initialize
    super WIDTH, HEIGHT
    self.caption = Gocia::APPLICATION_NAME
    @sidebar = Sidebar.new(self)
    @map    = Map.new(self)
    @cursor = Cursor.new
    @sound_engine = SoundEngine.new
    @controls = Controls::Mapper.new(self)
    @initializer = World::Initializer.new
  end

  def needs_cursor?
    @initializer.ready?
  end

  def draw
    with_loadscreen(_until: @initializer.ready?) do
      @sidebar.draw
      @map.draw
      @cursor.draw
    end
  end

  def button_down(id)
    @controls.button_down.trigger(signal: id)
  end

  def button_up(id)
    @controls.button_up.trigger(signal: id)
  end

  def world_engine
    @world_engine ||= @initializer.world_engine
  end
end
