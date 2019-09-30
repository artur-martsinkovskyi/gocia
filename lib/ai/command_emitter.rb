# frozen_string_literal: true

module AI
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
      @command_items = SortedSet.new
    end

    def emit
      if pending_command_item
        pending_command_item.command.call
      else
        command = command_builder.step
        command_items.add(CommandItem.new(tick: current_tick, command: command))
        command.call
      end
    end

    def absorb
      return unless pending_command_item

      pending_command_item.command.undo
    end

    private

    def command_builder
      @command_builder ||= CommandBuilder.new(self)
    end

    def world
      actor.world
    end

    def current_tick
      world.tick
    end

    def pending_command_item
      command_items.find { |ci| ci.tick == current_tick }
    end
  end
end
