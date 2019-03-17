module AI
  class CommandEmitter
    attr_reader :actor

    def initialize(actor)
      @actor = actor
      @commands = []
      @current_command_pos = 0
    end

    def emit
      result = if @current_command_pos == commands.size
                 command = command_builder.step
                 commands.push(command)
                 command
               else
                 commands[@current_command_pos]
               end
      @current_command_pos += 1
      result.call(actor)
    end

    def absorb
      return if @current_command_pos.zero?

      @current_command_pos -= 1
      commands[@current_command_pos].undo
    end

    private

    def command_builder
      CommandBuilder.new(actor)
    end

    attr_reader :commands
  end
end
