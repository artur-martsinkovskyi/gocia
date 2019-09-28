# frozen_string_literal: true

require_relative 'game_object'

class Tree < GameObject
  option(:fruit, Types.Instance(Fruit).optional, default: proc { Fruit.new if rand > 0.5 })

  attr_writer :fruit

  def to_h
    super.merge(
      fruit: fruit&.to_h
    ).compact
  end
end
