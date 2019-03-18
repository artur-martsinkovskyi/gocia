# frozen_string_literal: true

class WorldEngine
  attr_reader :world

  def initialize
    @world = World.new
  end
end
