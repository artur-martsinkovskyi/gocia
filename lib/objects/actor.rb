# frozen_string_literal: true

class Actor < GameObject
  option(:stats, Types.Instance(Actors::Stats), default: proc { Actors::Stats.new })

  has Slate

  def step
    command_emitter.emit
  end

  def to_h
    super.merge(
      stats: stats.to_h
    )
  end

  private

  def command_emitter
    @command_emitter ||= Ai::CommandEmitter.new(self)
  end
end
