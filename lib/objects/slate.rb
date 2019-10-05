# frozen_string_literal: true

class Slate < GameObject
  option :x, Types::Integer
  option :y, Types::Integer
  option :height, Types::Coercible::Float, default: proc { 0 }
  option :moist, Types::Coercible::Float, default: proc { 0 }

  memoize def biome
    Terrain::BiomePicker.call(height, moist)
  end

  def surrounding_slates(distance = 1)
    left_limit = [0, x - distance].max
    top_limit  = [0, y - distance].max

    $world.slates[left_limit..(x + distance)].map do |r|
      r[top_limit..(y + distance)]
    end.flatten
  end

  memoize def contents
    result = Slates::Contents.new
    r_value = biome.r_value
    i = x
    j = y

    if r_value
      r_field_max_value = $world.slates[(i - r_value)...(i + r_value)].map do |r|
        r[(j - r_value)...(j + r_value)]
      end.flatten.map(&:height).max

      result.push(Tree.new) if r_field_max_value == height
    end

    result
  end

  def to_h
    super.merge(
      x: x,
      y: y,
      height: height,
      moist: moist,
      biome: biome.to_h.slice(:name),
      contents: contents.map(&:to_h)
    )
  end

  def attributes
    super.merge(
      contents: contents.deep_attributes
    )
  end
end
