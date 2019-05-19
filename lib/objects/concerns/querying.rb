# frozen_string_literal: true

module Querying
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def id
    @id ||= self.class.send(:next_id)
  end

  def to_h
    super.merge(
      id: id
    )
  end

  module ClassMethods
    def new(*args)
      object = allocate
      object.send(:initialize, *args)
      objects.add(object)
      object
    end

    def find_by(parameters = {})
      objects.detect do |actor|
        parameters.all? do |key, value|
          actor.send(key) == value
        end
      end
    end

    def where(parameters = {})
      objects.select do |actor|
        parameters.all? do |key, value|
          actor.send(key) == value
        end
      end
    end

    def all
      objects
    end

    private

    def next_id
      if @id_counter
        @id_counter += 1
      else
        @id_counter = 1
      end
    end

    def objects
      @objects ||= Set.new
    end
  end
end
