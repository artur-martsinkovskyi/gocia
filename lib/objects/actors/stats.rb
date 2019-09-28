# frozen_string_literal: true

module Actors
  class Stats < GameObject
    option :hunger, Types::Integer, default: proc { 0 }
    option :health, Types::Integer, default: proc { 10 }

    def info
      {
        health: health,
        hunger: hunger
      }
    end
  end
end
