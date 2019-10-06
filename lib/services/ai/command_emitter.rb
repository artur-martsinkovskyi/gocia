# frozen_string_literal: true

module Ai
  class CommandEmitter
    COMMANDS_LIMIT = 150
    class CommandItem
      attr_reader :command, :tick

      def initialize(command:, tick:)
        @command = command
        @tick = tick
      end

      def <=>(other)
        tick <=> other.tick
      end
    end

    attr_reader :actor, :command_items

    def initialize(actor)
      @actor = actor
      @command_items = []
    end

    def emit
      return unless command_items.empty? || command_items.last.tick < current_tick

      command = command_builder.step
      command_items.push(CommandItem.new(tick: current_tick, command: command))
      command.call
    end

    private

    def command_builder
      @command_builder ||= CommandBuilder.new(self)
    end

    def current_tick
      $world.tick
    end
  end
end
