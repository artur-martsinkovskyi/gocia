# frozen_string_literal: true

require_relative 'game_object'
require_relative 'concerns/querying'

class Actor < GameObject
  include Querying

  attr_reader :world
  attr_reader :slate

  def initialize(world, slate)
    @world = world
    @slate = slate
  end

  def step
    command_emitter.emit
  end

  def step_back
    command_emitter.absorb
  end

  def move(to:)
    slate.contents.delete(self)
    to.contents.add(self)
    self.slate = to
  end

  def inspect
    to_h.merge(
      slate: slate
    )
  end

  private

  attr_writer :slate

  def command_emitter
    @command_emitter ||= AI::CommandEmitter.new(self)
  end
end
