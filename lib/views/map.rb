require 'pry'
require_relative 'tile'
require_relative '../objects/slate'
require_relative '../constants/dimensions'
require_relative 'view_objects/slate'

class Map
  include Dimensions
  attr_reader :current_map_x_offset, :current_map_y_offset

  def initialize(slates)
    @slates = slates
    @current_map_x_offset = 0
    @current_map_y_offset = 0
    @map_changed = true
  end

  def move(id)
    if id == Gosu::KB_D
      return if @current_map_x_offset + VIEWPORT_SIZE == TILE_COUNT

      @current_map_x_offset += VIEWPORT_SIZE
      @map_changed = true
    elsif id == Gosu::KB_A
      return if @current_map_x_offset - VIEWPORT_SIZE < 0

      @current_map_x_offset -= VIEWPORT_SIZE
      @map_changed = true
    elsif id == Gosu::KB_W
      return if @current_map_y_offset - VIEWPORT_SIZE < 0

      @current_map_y_offset -= VIEWPORT_SIZE
      @map_changed = true
    elsif id == Gosu::KB_S
      return if @current_map_y_offset + VIEWPORT_SIZE == TILE_COUNT

      @current_map_y_offset += VIEWPORT_SIZE
      @map_changed = true
    end
  end

  def draw
    tiles.each(&:draw)
  end

  def tiles
    if @tiles && !@map_changed
      @tiles
    else
      @map_changed = false
      @tiles = @slates[current_map_x].map.with_index do |row, i|
        row[current_map_y].map.with_index do |slate, j|
          ViewObjects::Slate.new(
            x: i,
            y: j,
            slate: slate
          )
        end
      end.flatten
    end
  end

  def current_map_y
    @current_map_y_offset..(@current_map_y_offset + VIEWPORT_SIZE)
  end

  def current_map_x
    @current_map_x_offset...(@current_map_x_offset + VIEWPORT_SIZE)
  end
end
