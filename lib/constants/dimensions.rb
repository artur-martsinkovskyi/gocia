# frozen_string_literal: true

module Dimensions
  MAP_SIZE = Gocia.config.interface.map_size

  SIDEBAR_WIDTH = Gocia.config.interface.sidebar_width

  VIEWPORT_SIZE = Gocia.config.interface.viewport_size

  TILE_COUNT = Gocia.config.world.tile_count

  TILE_SIZE = MAP_SIZE / VIEWPORT_SIZE
  HEIGHT = MAP_SIZE
  WIDTH = MAP_SIZE + SIDEBAR_WIDTH
end
