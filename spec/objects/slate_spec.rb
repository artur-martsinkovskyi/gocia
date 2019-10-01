# frozen_string_literal: true

describe Slate do
  subject(:slate) { described_class.new(world: world, x: 1, y: 1) }

  let(:world) do
    double(
      'World',
      slates: double
    )
  end

  describe '.new' do
    context 'when height and moist is not given' do
      it { is_expected.to have_attributes(height: 0, moist: 0) }
    end

    context 'when height and moist are given' do
      subject(:slate) { described_class.new(world: world, x: 1, y: 1, height: height, moist: moist) }

      let(:height) { 12 }
      let(:moist)  { 12 }

      it { is_expected.to have_attributes(height: height, moist: moist) }
    end

    context 'when r_value is absent' do
      before do
        allow(Terrain::BiomePicker).to receive(:call).and_return(
          double(r_value: nil)
        )
      end

      it 'does not have a tree in the content' do
        expect(slate.contents).not_to include(instance_of(Tree))
      end
    end

    context 'when r_value is present' do
      before do
        allow(Terrain::BiomePicker).to receive(:call).and_return(
          double(r_value: 10)
        )
      end

      context 'when slate is not the high point' do
        before do
          allow(world).to receive(:slates).and_return(double("[]": []))
        end

        it 'does not have a tree in the content' do
          expect(slate.contents).not_to include(instance_of(Tree))
        end
      end

      context 'when slate is a high point' do
        before do
          allow(world).to receive(:slates).and_return(double("[]": [double('[]': slate)]))
        end

        it 'does not have a tree in the content' do
          expect(slate.contents).to include(instance_of(Tree))
        end
      end
    end
  end

  describe '#biome' do
    subject(:slate) { described_class.new(world: world, x: 1, y: 1, height: height, moist: moist) }

    let(:height) { 100 }
    let(:moist)  { 14 }

    before do
      allow(Terrain::BiomePicker).to receive(:call)
    end

    it 'calls BiomePicker' do
      slate.biome
      expect(Terrain::BiomePicker).to have_received(:call)
        .with(height, moist)
    end
  end

  describe '#surrounding_slates' do
    subject(:slate) { described_class.new(world: world, x: x, y: y) }

    let(:slates) do
      (1..25).each_slice(5).map(&:itself).tap { |a| p a }
    end

    let(:world) do
      double('World', slates: slates)
    end

    before do
      slates[x][y] = slate
    end

    context 'when parameter is supplied' do
      let(:x) { 2 }
      let(:y) { 2 }

      it 'returns surrounding slates' do
        expect(slate.surrounding_slates(2)).to eq(
          [
            1, 2, 3, 4, 5,
            6, 7, 8, 9, 10,
            11, 12, slate, 14, 15,
            16, 17, 18, 19, 20,
            21, 22, 23, 24, 25
          ]
        )
      end
    end

    context 'when no parameter supplied' do
      let(:x) { 1 }
      let(:y) { 1 }

      it 'returns surrounding slates' do
        expect(slate.surrounding_slates).to eq(
          [
            1, 2, 3,
            6, slate, 8,
            11, 12, 13
          ]
        )
      end

      context 'when left and top limit are close' do
        let(:x) { 0 }
        let(:y) { 0 }

        it 'returns surrounding slates' do
          expect(slate.surrounding_slates).to eq(
            [
              slate, 2,
              6, 7
            ]
          )
        end
      end
    end
  end

  describe '#to_h' do
    it 'has proper attributes' do
      expect(slate.to_h).to match(
        x: 1,
        y: 1,
        height: 0.0,
        moist: 0.0,
        contents: [],
        type: 'slate',
        biome: { name: 'deep_water' }
      )
    end
  end
end
