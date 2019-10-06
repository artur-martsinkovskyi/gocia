# frozen_string_literal: true

class ConstrainedParameter
  extend Dry::Initializer

  option :lower_bound, Types::Integer
  option :upper_bound, Types::Integer
  option :value, Types::Integer

  attr_writer :value

  def inc(by = 1)
    self.value = [value + by, upper_bound].min
  end

  def dec(by = 1)
    self.value = [value - by, lower_bound].max
  end

  def set(value)
    unless (lower_bound..upper_bound).include?(value)
      raise ArgumentError, "value #{value} out of bounds (#{lower_bound} #{upper_bound})"
    end

    self.value = value
  end
end
