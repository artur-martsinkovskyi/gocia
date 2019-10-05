# frozen_string_literal: true

module ChangeTracking
  class ChangeProcessor < ::Service
    attr_reader :object, :change, :direction

    def initialize(object, change, direction:)
      @object = object
      @change = change
      @direction = direction
    end

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
        receiver.send('delete', Slates::Contents.to_content(change.from))
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('push', Slates::Contents.to_content(change.from))
      end
    end

    def remove
      if direction == :rollback
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('push', Slates::Contents.to_content(change.from))
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path + ".#{array_path}")
        receiver.send('delete', Slates::Contents.to_content(change.from))
      end
    end

    def array_path
      change.accessor.split('[')[0]
    end
  end
end
