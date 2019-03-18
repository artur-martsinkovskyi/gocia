# frozen_string_literal: true

require_relative 'game_object'

class Fruit < GameObject
  def initialize
    @poisonous = rand < 0.1
  end

  def poisonous?
    @poisonous
  end

  def to_h
    super.merge(
      poisonous: poisonous?
    )
  end
end
