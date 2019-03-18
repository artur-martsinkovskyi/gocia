# frozen_string_literal: true

class Tree < GameObject
  attr_reader :fruit

  def initialize
    @fruit = Fruit.new if rand > 0.5
  end

  def to_h
    super.merge(
      fruit: fruit.to_h
    )
  end
end
