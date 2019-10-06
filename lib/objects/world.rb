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
      [Actor, Slate, Tree].each do |object_class|
        object_class.object_pool.each_value { |object| object.rollup(to: @tick) }
      end
    end
    @tick += 1
  end

  def step_back
    return if @tick.zero?

    @rollbacked_tick ||= @tick
    @tick -= 1
    [Actor, Slate, Tree].each do |object_class|
      object_class.object_pool.each_value { |object| object.rollback(to: @tick) }
    end
  end
end
