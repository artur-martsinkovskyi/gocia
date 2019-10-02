# frozen_string_literal: true

require_relative '../service'

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
      position = change.accessor.match(/[a-zA-Z0-9]\[(\d*)\]/)[1].to_i
      array = change.accessor.split('[')[0]
      if direction == :rollback
        receiver = object.instance_eval(change.object_path.concat(".#{array}"))
        receiver.send('delete_at', position)
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path.concat(".#{array}"))
        receiver.send('insert', position, change.to)
      end
    end

    def remove
      position = change.accessor.match(/[a-zA-Z0-9]\[(\d*)\]/)[1].to_i
      array = change.accessor.split('[')[0]
      if direction == :rollback
        receiver = object.instance_eval(change.object_path.concat(".#{array}"))
        receiver.send('delete_at', position)
      elsif direction == :rollup
        receiver = object.instance_eval(change.object_path.concat(".#{array}"))
        receiver.send('insert', position, change.to)
      end
    end
  end
end
