module Controls
  class Mapper
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def button_up
      @button_up ||= ButtonUpMapper.new(context)
    end

    def button_down
      @button_down ||= ButtonDownMapper.new(context)
    end
  end
end
