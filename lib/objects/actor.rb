# frozen_string_literal: true

require_relative 'game_object'

class Actor < GameObject
  attr_accessor :slate
  attr_reader :world

  def initialize(world)
    @world = world
  end

  def step
    command_emitter.emit
  end

  def step_back
    command_emitter.absorb
  end

  def to_h
    super
  end

  private

  def command_emitter
    @command_emitter ||= AI::CommandEmitter.new(self)
  end
end
