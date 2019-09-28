# frozen_string_literal: true

require_relative 'game_object'
require_relative 'concerns/querying'

class Actor < GameObject
  include Querying

  attr_reader :world
  attr_reader :slate
  attr_accessor :health

  def initialize(world, slate)
    @world = world
    @slate = slate
    @health = 10
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
    self.health -= 1
  end

  def consume(_)
    self.health += 2 if health <= 8
  end

  def deconsume(_)
    self.health -= 2 if self.health >= 2
  end

  def to_h
    super.merge(
      health: health
    )
  end

  private

  attr_writer :slate

  def command_emitter
    @command_emitter ||= AI::CommandEmitter.new(self)
  end
end
