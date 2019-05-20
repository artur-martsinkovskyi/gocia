# frozen_string_literal: true

require 'ostruct'

module Ostructify
  refine Hash do
    def to_ostruct
      OpenStruct.new(
        map do |key, value|
          [
            key,
            if value.is_a?(Hash)
              value.to_ostruct
            else
              value
            end
          ]
        end.to_h
      )
    end

    def to_frozen_ostruct
      OpenStruct.new(
        map do |key, value|
          [
            key,
            if value.is_a?(Hash)
              value.to_frozen_ostruct
            else
              value
            end
          ]
        end.to_h
      ).freeze
    end
  end
end
