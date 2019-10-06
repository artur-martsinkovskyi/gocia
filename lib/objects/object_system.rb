# frozen_string_literal: true

module ObjectSystem
  def self.included(base)
    base.extend ClassMethods
  end

  def initialize(*)
    self.class.object_pool[object_id] = self
    super
  end

  module ClassMethods
    def object_pool
      @object_pool ||= {}
    end

    def has(object_class, default: nil)
      raise ArgumentError, 'has source must be a class' unless object_class.is_a?(Class)

      object_class_name = object_class.to_s.downcase
      parameter_name = "#{object_class_name}_id".to_sym
      option parameter_name, Types::Integer.optional, optional: true, default: default
      attr_writer parameter_name

      define_method object_class_name do
        object_class.object_pool[send(parameter_name)]
      end

      define_method "#{object_class_name}=" do |object|
        if object.nil?
          send("#{parameter_name}=", nil)
        else
          send("#{parameter_name}=", object.object_id)
        end
      end
    end
  end
end
