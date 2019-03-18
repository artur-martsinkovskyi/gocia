# frozen_string_literal: true

describe Slate do
  describe '.new' do
    context 'when height and moist is not given' do
      subject(:slate) { described_class.new(1, 1) }

      it 'has height set to 0' do
        expect(slate.height).to eq(0)
      end

      it 'has moist set to 0' do
        expect(slate.moist).to eq(0)
      end

      describe '#contents' do
        subject { slate.contents }

        it { is_expected.to be_a(Set) }
      end


      describe '#biome' do
        subject(:slate) { described_class.new(1, 1, height, moist) }

        let(:height) { spy }
        let(:moist)  { spy }

        before do
          allow(Terrain::BiomePicker).to receive(:call)
        end

        it 'calls BiomePicker' do
          slate.biome
          expect(Terrain::BiomePicker).to have_received(:call)
            .with(height, moist)
        end

      end

      describe '#to_h' do
        it 'has proper attributes' do
          expect(slate.to_h).to match(
            x: 1,
            y: 1,
            height: 0,
            moist: 0,
            contents: [],
            type: 'Slate',
            biome: { name: 'deep_water' }
          )
        end
      end
    end
  end
end
