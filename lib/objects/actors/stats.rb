# frozen_string_literal: true

require_relative '../../util/constrained_parameter'

module Actors
  class Stats < GameObject
    option(:hunger, Types::Instance(ConstrainedParameter), default: proc do
      ConstrainedParameter.new(
        lower_bound: 0,
        upper_bound: 10,
        value: 0
      )
    end)
    option(:health, Types::Instance(ConstrainedParameter), default: proc do
      ConstrainedParameter.new(
        lower_bound: 0,
        upper_bound: 10,
        value: 10
      )
    end)
    option(:alive, Types::Bool, default: proc { true })
    attr_writer :alive

    def to_h
      {
        health: health.value,
        hunger: hunger.value,
        alive: alive
      }
    end
  end
end
