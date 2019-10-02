# frozen_string_literal: true

require_relative 'game_object'
require_relative 'fruit'

class Tree < GameObject
  option(:fruit_id, Types::Integer.optional, default: proc { Fruit.new.object_id if rand > 0.5 })

  attr_writer :fruit_id

  def fruit
    Fruit.object_pool[fruit_id]
  end

  def to_h
    super.merge(
      fruit: fruit&.to_h
    ).compact
  end
end
