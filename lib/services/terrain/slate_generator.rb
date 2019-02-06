require 'perlin_noise'

module Terrain
  class SlateGenerator
    def initialize(width, height)
      @width = width
      @height = height
      @noise = Perlin::Noise.new(2)
    end

    def call
      Array.new(@width) do |y|
        Array.new(@height) do |x|
          @noise[
            (x.to_f / @width) - 0.5,
            (y.to_f / @height) - 0.5
          ]
        end
      end
    end
  end
end

