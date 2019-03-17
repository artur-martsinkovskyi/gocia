module AI
  class CommandBuilder
    attr_reader :actor

    def initialize(actor)
      @actor = actor
    end

    def step
      ::MoveCommand.new
    end
  end
end
