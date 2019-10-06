# frozen_string_literal: true

class Rotator < Operation
  attribute :angle, Types::Integer.constrained(gteq: 0, lteq: 360)

  def call
    Enumerator.new do |yielder|
      next_angle = 0
      loop do
        yielder.yield next_angle = (next_angle + angle) % 360
      end
    end
  end
end
