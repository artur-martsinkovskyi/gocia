class Tree
  attr_reader :fruit

  def initialize
    @fruit = if rand > 0.5
               Fruit.new
             end
  end

  def to_h
    {
      type: self.class.name,
      fruit: fruit.to_h
    }
  end
end
