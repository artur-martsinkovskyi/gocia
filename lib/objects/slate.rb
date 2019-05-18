# frozen_string_literal: true

require 'set'

class Slate < GameObject
  attr_reader :x, :y, :height, :moist

  def initialize(world, x, y, height = 0, moist = 0)
    @world = world
    @x = x
    @y = y
    @height = height
    @moist = moist
  end

  def biome
    @biome ||= Terrain::BiomePicker.call(height, moist)
  end

  def surrounding_slates(distance = 1)
    left_limit = [0, x - distance].max
    top_limit  = [0, y - distance].max

    world.slates[left_limit..(x + distance)].map { |r| r[top_limit..(y + distance)] }.flatten
  end

  def to_h
    super.merge(
      x: x,
      y: y,
      height: height,
      moist: moist,
      biome: biome.to_h.compact,
      contents: contents.map(&:to_h)
    )
  end

  def contents
    @contents ||= begin
                    result = Set.new
                    r_value = biome.r_value
                    i = x
                    j = y

                    return result unless r_value

                    r_field_max_value = world.slates[(i - r_value)...(i + r_value)].map do |r|
                      r[(j - r_value)...(j + r_value)]
                    end.flatten.map(&:height).max

                    result.add(Tree.new) if r_field_max_value == height

                    result
                  end
  end

  private

  attr_reader :world
end
