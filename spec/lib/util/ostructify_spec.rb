# frozen_string_literal: true

class TestHash
  using Ostructify
  def initialize(h)
    @h = h
  end

  def to_ostruct
    @h.to_ostruct
  end

  def to_frozen_ostruct
    @h.to_frozen_ostruct
  end
end

shared_examples 'to_ostruct' do
  let(:hash) { { a: :b, c: :d } }

  it { is_expected.to be_instance_of(OpenStruct) }
  it { is_expected.to have_attributes(a: :b, c: :d) }

  context 'when there is a nested hash' do
    let(:hash) do
      {
        a: {
          b: {
            c: :d
          }
        }
      }
    end

    it 'resolves a hash to a nested ostruct' do
      expect(subject.a.b.c).to eq(:d)
    end
  end
end

describe Ostructify do
  describe '#to_ostruct' do
    subject { TestHash.new(hash).to_ostruct }

    it_behaves_like 'to_ostruct'
  end

  describe '#to_frozen_ostruct' do
    subject { TestHash.new(hash).to_frozen_ostruct }

    let(:hash) do
      {
        a: {
          b: {
            c: :d
          }
        }
      }
    end

    it_behaves_like 'to_ostruct'

    it 'returns deeply frozen ostruct' do
      expect(subject).to be_frozen
      expect(subject.a).to be_frozen
      expect(subject.a.b).to be_frozen
    end
  end
end
