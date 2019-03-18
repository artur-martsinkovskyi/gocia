# frozen_string_literal: true

module Dimensions
  SIDEBAR_WIDTH = 400 # px
  MAP_SIZE = 1024 # px
  TILE_COUNT = 256 # tiles
  VIEWPORT_SIZE = 64 # tiles
  TILE_SIZE = MAP_SIZE / VIEWPORT_SIZE
  HEIGHT = MAP_SIZE
  WIDTH = MAP_SIZE + SIDEBAR_WIDTH
end
