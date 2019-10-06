# frozen_string_literal: true

module ChangeTracking
  class ChangeProcessor < Operation
    attribute :object, Types::Any
    attribute :change, Types::Instance(Change)
    attribute :direction, Types::Symbol.enum(:rollup, :rollback)

    def call
      case change.change_type
      when Change::ALTER then alter
      when Change::ADD then add
      when Change::REMOVE then remove
      else
        raise ArgumentError, "Unknown change type #{change.change_type}"
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
        remove_from_array
      elsif direction == :rollup
        add_to_array
      end
    end

    def remove
      if direction == :rollback
        add_to_array
      elsif direction == :rollup
        remove_from_array
      end
    end

    def add_to_array
      receiver = object.instance_eval(change.object_path + ".#{array_path}")
      receiver.send('push', to_object_form(change.from))
    end

    def remove_from_array
      receiver = object.instance_eval(change.object_path + ".#{array_path}")
      receiver.send('delete', to_object_form(change.from))
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
