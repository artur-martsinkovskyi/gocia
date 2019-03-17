class WorldEngine
  include Dimensions
  attr_reader :world

  def initialize
    @world = World.new
  end
end
