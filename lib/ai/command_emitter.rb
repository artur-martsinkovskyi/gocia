# frozen_string_literal: true

module AI
  class CommandEmitter
    COMMANDS_LIMIT = 150

    attr_reader :actor, :commands

    def initialize(actor)
      @actor = actor
      @commands = []
      @current_command_pos = 0
    end

    def emit
      result = if @current_command_pos == commands.size
                 if commands.size > COMMANDS_LIMIT
                   commands.shift
                   @current_command_pos -= 1
                 end
                 command = command_builder.step
                 commands.push(command)
                 command
               else
                 commands[@current_command_pos]
               end
      @current_command_pos += 1
      result.call
    end

    def absorb
      return if @current_command_pos.zero?

      @current_command_pos -= 1
      commands[@current_command_pos].undo
    end

    private

    def command_builder
      @command_builder ||= CommandBuilder.new(self)
    end
  end
end
