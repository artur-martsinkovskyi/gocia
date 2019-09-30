# frozen_string_literal: true

require 'singleton'

class World
  include Dimensions
  include Singleton

  attr_reader :slates, :actors, :tick

  def initialize
    @slates = Terrain::SlateMapGenerator.call(self, TILE_COUNT, TILE_COUNT)
    @actors = Actors::Initializer.new(self).call
    @tick = 0
  end

  def step
    @tick += 1
    actors.each(&:step)
  end

  def step_back
    return if @tick.zero?

    @tick -= 1
    actors.each(&:step_back)
  end
end
