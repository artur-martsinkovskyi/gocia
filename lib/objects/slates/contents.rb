# frozen_string_literal: true

module Slates
  class Contents
    include Enumerable

    def initialize
      @contents = []
    end

    def delete(obj)
      contents.delete(
        [obj.class, obj.object_id]
      )
    end

    def insert(position, obj)
      contents.insert(
        position,
        [obj.class, obj.object_id]
      )
    end

    def push(obj)
      contents.push(
        [obj.class, obj.object_id]
      )
    end

    def delete_at(position)
      contents.delete_at(position)
    end

    def each
      contents.each do |klass, object_id|
        yield klass.object_pool[object_id]
      end
    end

    def deep_attributes
      contents
    end

    def self.to_content(obj)
        [obj.class, obj.object_id]
    end

    private

    attr_reader :contents
  end
end
