# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

describe ChangeTracker do
  class DummyGameObject
    extend Dry::Initializer
    include ChangeTracker

    param :name, Types::String
    param :id, Types::Integer
    attr_writer :name, :id

    private

    def current_tick
      1
    end

    def deep_attributes
      self.class.dry_initializer.attributes(self)
    end
  end

  let(:tracked_dummy) { DummyGameObject.new('Jerald', 25) }

  describe '#update' do
    subject do
      tracked_dummy.update do |dummy|
        dummy.name = 'Ford'
        dummy.id = 85
      end
    end

    it { is_expected.to have_attributes(name: 'Ford', id: 85) }
  end

  describe '#rollback' do
    subject { tracked_dummy.rollback }

    before do
      tracked_dummy.update do |dummy|
        dummy.name = 'Ford'
        dummy.id = 85
      end
    end

    it { is_expected.to have_attributes(name: 'Jerald', id: 25) }
  end
end
