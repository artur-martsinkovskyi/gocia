# frozen_string_literal: true

require_relative 'game_object'
require_relative 'world'
require_relative 'slate'
require_relative 'concerns/querying'
Dir[File.join(File.dirname(__FILE__), 'actors/*.rb')].each { |f| require f }

class Actor < GameObject
  include Querying

  option :world, Types.Instance(World)
  option :slate, Types.Instance(Slate)
  option(:stats, Types.Instance(Actors::Stats), default: proc { Actors::Stats.new })
  attr_writer :slate

  def step
    command_emitter.emit
  end

  def step_back
    command_emitter.absorb
  end

  def to_h
    super.merge(
      stats: stats.to_h
    )
  end

  private

  def command_emitter
    @command_emitter ||= AI::CommandEmitter.new(self)
  end
end
