# frozen_string_literal: true

require_relative 'game_object'
require_relative 'world'
require_relative 'slate'
Dir[File.join(File.dirname(__FILE__), 'actors/*.rb')].each { |f| require f }

class Actor < GameObject
  option :slate_id, Types::Integer
  option(:stats, Types.Instance(Actors::Stats), default: proc { Actors::Stats.new })

  attr_writer :slate_id

  def slate
    Slate.object_pool[slate_id]
  end

  def slate=(slate)
    self.slate_id = slate.object_id
  end

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
