# frozen_string_literal: true

module Controls
  class Mapper
    extend Dry::Initializer
    extend Memoist
    param :context, Types.Instance(Window)

    memoize def button_up
      ButtonUpMapper.new(context)
    end

    memoize def button_down
      ButtonDownMapper.new(context)
    end
  end
end
