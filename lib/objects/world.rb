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
    if @rollbacked_tick.nil?
      actors.each(&:step)
    else
      @rollbacked_tick = nil if @rollbacked_tick == @tick
      Actor.object_pool.each_value { |actor| actor.rollup(to: @tick) }
      Slate.object_pool.each_value { |slate| slate.rollup(to: @tick) }
    end
    @tick += 1
  end

  def step_back
    return if @tick.zero?

    @rollbacked_tick ||= @tick
    @tick -= 1
    Actor.object_pool.each_value { |actor| actor.rollback(to: @tick) }
    Slate.object_pool.each_value { |slate| slate.rollback(to: @tick) }
  end
end
