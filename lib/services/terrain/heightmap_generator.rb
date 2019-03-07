require 'perlin'
require_relative '../service'

module Terrain
  class HeightmapGenerator < Service
    private

    def initialize(width, height, noise_seed = 2)
      @width = width
      @height = height
      @noise_seed = noise_seed
    end

    def call
      @noise = Perlin::Generator.new(@noise_seed, 2.0, 1)
      Array.new(@width) do |y|
        Array.new(@height) do |x|
          nx = 6 * (x.to_f / @width - 0.5)
          ny = 6 * (y.to_f / @height - 0.5)
          e = 1    * noise(1 * nx, 1 * ny) +
              0.5  * noise(2 * nx, 2 * ny) +
              0.25 * noise(8 * nx, 8 * ny)
          e /= 1 + 0.5 + 0.25
          e = Math.cos(e)**6
          island_normalize(e, nx, ny)
        end
      end
    end

    private

    def noise(x, y)
      (@noise[x, y] / 2) + 0.5
    end


    def island_normalize(e, nx, ny)
      nnx = (nx / 6)
      nny = (ny / 6)

      # d = 2 * [nnx.abs, nny.abs].max
      d = 2 * Math.sqrt(nnx*nnx + nny*nny)
      e = e + 0.1 - d**9
      e = e > 1 ? 1 : e
      e = e < 0 ? 0 : e
    end
  end
end
