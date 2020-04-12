# frozen_string_literal: true

require 'rmagick'

class Window < Gosu::Window
  include Dimensions
  include WithLoadscreen

  attr_reader :sound_engine,
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
    @initializer = WorldInitializer.new
    @pause = false
  end

  def needs_cursor?
    @initializer.ready?
  end

  def draw
    with_loadscreen(before: @initializer.ready?) do
      @sidebar.draw
      @map.draw
      @cursor.draw
    end
  end

  def button_down(id)
    @controls.button_down.trigger(signal: id)
    world_engine.world.step if id == Gosu::KB_Y
    world_engine.world.step_back if id == Gosu::KB_T
    @pause = !@pause if id == Gosu::KB_P
    # rubocop:disable Lint/Debugger
    binding.pry if id == Gosu::KB_C
    # rubocop:enable Lint/Debugger
  end

  def button_up(id)
    @controls.button_up.trigger(signal: id)
  end

  def world_engine
    @world_engine ||= begin
                        result = @initializer.world_engine
                        $world = result.world
                        result
                      end
  end
end
