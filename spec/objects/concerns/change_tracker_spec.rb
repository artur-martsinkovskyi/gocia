# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

describe ChangeTracker do
  class OtherDummyGameObject
    extend Dry::Initializer
    include ChangeTracker

    param :name, Types::String
    param :id, Types::Integer
    param :ids, Types::Array.of(Types::Integer)
    attr_writer :name, :id

    def deep_attributes
      self.class.dry_initializer.attributes(self)
    end
  end

  class DummyGameObject
    extend Dry::Initializer
    include ChangeTracker

    param :name, Types::String
    param :id, Types::Integer
    param :inner, Types.Instance(OtherDummyGameObject)
    attr_writer :name, :id

    def deep_attributes
      self.class.dry_initializer.attributes(self).merge(inner: inner.deep_attributes)
    end

    def tick
      1
    end
  end

  let(:tracked_dummy) { DummyGameObject.new('Jerald', 25, OtherDummyGameObject.new('Hello', 12, [1])) }

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
        dummy.inner.id = 5
        dummy.inner.ids << tracked_dummy
      end
    end

    it { is_expected.to have_attributes(name: 'Jerald', id: 25) }

    it 'rolls back inner object' do
      expect(tracked_dummy.inner.id).to eq(5)
      expect(tracked_dummy.inner.ids).to include(tracked_dummy)
      subject
      expect(tracked_dummy.inner.id).to eq(12)
      expect(tracked_dummy.inner.ids).not_to include(tracked_dummy)
    end
  end

  describe '#rollup' do
    subject { tracked_dummy.rollup }

    before do
      tracked_dummy.update do |dummy|
        dummy.name = 'Ford'
        dummy.id = 85
        dummy.inner.id = 5
        dummy.inner.ids << tracked_dummy
      end
      tracked_dummy.rollback
    end

    it { is_expected.to have_attributes(name: 'Ford', id: 85) }

    it 'rolls up inner object' do
      expect(tracked_dummy.inner.id).to eq(12)
      expect(tracked_dummy.inner.ids).not_to include(tracked_dummy)
      subject
      expect(tracked_dummy.inner.id).to eq(5)
      expect(tracked_dummy.inner.ids).to include(tracked_dummy)
    end
  end
end
