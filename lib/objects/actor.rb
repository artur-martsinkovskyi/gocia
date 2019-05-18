# frozen_string_literal: true

require_relative 'game_object'

class Actor < GameObject
  attr_reader :world
  attr_reader :slate

  def self.new(*args)
    actor = allocate
    actor.send(:initialize, *args)
    actors.add(actor)
    actor
  end

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

  def to_h
    super.merge(
      id: id
    )
  end

  def id
    @id ||= self.class.next_id
  end

  def self.all
    actors
  end

  def self.find_by(parameters = {})
    actors.select do |actor|
      parameters.map do |key, value|
        actor.send(key) == value
      end
    end
  end

  private

  def self.actors
    @actors ||= Set.new
  end

  def self.next_id
    if @id_counter
      @id_counter += 1
    else
      @id_counter = 1
    end
  end

  attr_writer :slate

  def command_emitter
    @command_emitter ||= AI::CommandEmitter.new(self)
  end
end
