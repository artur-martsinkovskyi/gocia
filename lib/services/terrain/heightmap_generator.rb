require 'perlin'
require_relative '../service'

module Terrain
  class HeightmapGenerator < Service
    attr_reader :max_noise

    private

    def initialize(width, height)
      @width = width
      @height = height
      @noise = Perlin::Generator.new(122, 2.0, 1)
    end

    def call
      Array.new(@width) do |y|
        Array.new(@height) do |x|
          nx = 6 * (x.to_f / @width - 0.5)
          ny = 6 * (y.to_f / @height - 0.5)
          e = 1    * noise(1 * nx, 1 * ny) +
              0.5  * noise(2 * nx, 2 * ny) +
              0.25 * noise(8 * nx, 8 * ny)
          e /= 1 + 0.5 + 0.25
          e ** 2
        end
      end
    end

    private

    def noise(x, y)
      (@noise[x, y] / 2) + 0.5
    end
  end
end
