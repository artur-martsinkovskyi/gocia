# frozen_string_literal: true

require 'perlin'

module Terrain
  class HeightmapGenerator < Operation
    attribute :width, Types::Integer
    attribute :height, Types::Integer
    attribute(:noise_seed, Types::Integer.default { Gocia.config.world.seed })

    def call
      Array.new(width) do |y|
        Array.new(height) do |x|
          nx = 5 * (x.to_f / width - 0.5)
          ny = 5 * (y.to_f / height - 0.5)
          e = e_value(octaves: Gocia.config.world.octaves, nx: nx, ny: ny)
          e = Math.cos(e)**6
          if Gocia.config.world.island
            island_normalize(e, nx, ny)
          else
            e
          end
        end
      end
    end

    def e_value(octaves:, nx:, ny:)
      e = noise(nx, ny)
      octave_value = 0.5
      noise_stretch = 2
      division_factor = 1

      (octaves - 1).times do
        e += octave_value * noise(noise_stretch * nx, noise_stretch * ny)
        division_factor += octave_value
        octave_value /= 2
        noise_stretch **= 3
      end

      e / division_factor
    end

    def noise(x, y)
      (noise_generator[x, y] / 2) + 0.5
    end

    def island_normalize(e, nx, ny)
      nnx = (nx / 6)
      nny = (ny / 6)

      d = 2.4 * Math.sqrt(nnx * nnx + nny * nny)
      e = e + 0.1 - d**9
      e = e > 1 ? 1 : e
      e.negative? ? 0 : e
    end

    memoize def noise_generator
      Perlin::Generator.new(noise_seed, 2.0, 1)
    end
  end
end
