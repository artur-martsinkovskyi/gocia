# frozen_string_literal: true

require 'singleton'

class World
  include Dimensions
  include Singleton
  extend Dry::Initializer
  extend Memoist

  option(:slates, Types::Array, default: lambda do
    Terrain::SlateMapGenerator.call(TILE_COUNT, TILE_COUNT)
  end)
  option :tick, Types::Integer, default: proc { 0 }
  option :rollbacked_tick, Types::Integer, optional: true

  def step
    if rollbacked_tick.nil?
      actors.each(&:step)
    else
      self.rollbacked_tick = nil if rollbacked_tick == tick
      [Actor, Slate, Tree].each do |object_class|
        object_class.object_pool.each_value { |object| object.rollup(to: tick) }
      end
    end
    self.tick += 1
  end

  def step_back
    return if tick.zero?

    self.rollbacked_tick ||= tick
    self.tick -= 1
    [Actor, Slate, Tree].each do |object_class|
      object_class.object_pool.each_value { |object| object.rollback(to: tick) }
    end
  end

  memoize def actors
    Actors::Initializer.new(world: self).call
  end

  private

  attr_writer :tick
  attr_writer :rollbacked_tick
end
