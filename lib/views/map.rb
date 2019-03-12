class Map
  include Dimensions
  attr_reader :current_map_x_offset, :current_map_y_offset

  def initialize(window)
    @current_map_x_offset = 0
    @current_map_y_offset = 0
    @map_changed = true
    @window = window
  end

  def move(direction)
    if direction == :right
      return if @current_map_x_offset + VIEWPORT_SIZE == TILE_COUNT

      @current_map_x_offset += VIEWPORT_SIZE
      @map_changed = true
    elsif direction == :left
      return if @current_map_x_offset - VIEWPORT_SIZE < 0

      @current_map_x_offset -= VIEWPORT_SIZE
      @map_changed = true
    elsif direction == :up
      return if @current_map_y_offset - VIEWPORT_SIZE < 0

      @current_map_y_offset -= VIEWPORT_SIZE
      @map_changed = true
    elsif direction == :down
      return if @current_map_y_offset + VIEWPORT_SIZE == TILE_COUNT

      @current_map_y_offset += VIEWPORT_SIZE
      @map_changed = true
    end
  end

  def draw
    if @slates.nil? || @map_changed
      @map_changed = false
      @slates = window.world_engine.slates[current_map_x].map.with_index do |row, i|
        row[current_map_y].map.with_index do |slate, j|
          ViewObjects::Slate.new(
            x: i,
            y: j,
            slate: slate
          )
        end
      end.flatten
    end

    @slates.each(&:draw)
  end

  private

  attr_reader :window

  def current_map_y
    @current_map_y_offset..(@current_map_y_offset + VIEWPORT_SIZE)
  end

  def current_map_x
    @current_map_x_offset...(@current_map_x_offset + VIEWPORT_SIZE)
  end
end
