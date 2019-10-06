# frozen_string_literal: true

module ChangeTracking
  class ChangeProcessor < ::Service
    attribute :object, Types::Any
    attribute :change, Types::Instance(Change)
    attribute :direction, Types::Symbol.enum(:rollup, :rollback)

    def call
      case change.change_type
      when Change::ALTER then alter
      when Change::ADD then add
      when Change::REMOVE then remove
      end
    end

    private

    def alter
      if direction == :rollback
        receiver = object.instance_eval(change.object_path)
        receiver.send("#{change.accessor}=", change.from)
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path)
        receiver.send("#{change.accessor}=", change.to)
      end
    end

    def add
      if direction == :rollback
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('delete', to_object_form(change.from))
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('push', to_object_form(change.from))
      end
    end

    def remove
      if direction == :rollback
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('push', to_object_form(change.from))
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('delete', to_object_form(change.from))
      end
    end

    def to_object_form(obj)
      return obj unless obj.is_a?(Array)

      klass, object_id = obj
      klass.object_pool[object_id]
    end

    def array_path
      change.accessor.split('[')[0]
    end
  end
end
