# frozen_string_literal: true

describe Terrain::BiomePicker do
  describe '.call' do
    where(:case_name, :elevation, :moist, :biome) do
      [
        ['snow', 0.97, 0.7, Biomes::SNOW],
        ['rocks', 0.92, 0.7, Biomes::ROCKS],
        ['mountain', 0.85, 0.7, Biomes::MOUNTAIN],
        ['desert', 0.75, 0.7, Biomes::DESERT],
        ['grassland', 0.65, 0.7, Biomes::GRASSLAND],
        ['shoal on moist', 0.65, 0.9, Biomes::SHOAL],
        ['valley', 0.5, 0.9, Biomes::VALLEY],
        ['coastline', 0.25, 0.2, Biomes::COASTLINE],
        ['shoal', 0.15,  0.2, Biomes::SHOAL],
        ['water', 0.06,  0.2, Biomes::WATER],
        ['deep_water', 0.03,  0.2, Biomes::DEEP_WATER]
      ]
    end

    subject { described_class.call(elevation, moist) }

    with_them do
      it { is_expected.to eq(biome) }
    end
  end

  describe '#water?' do
    where(:case_name, :biome) do
      [
        ['shoal', described_class::SHOAL],
        ['water', described_class::WATER],
        ['deep_water', described_class::DEEP_WATER]
      ]
    end

    subject { biome }

    with_them do
      it { is_expected.to be_water }
      it { is_expected.not_to be_land }
    end
  end


  describe '#land?' do
    where(:case_name, :biome) do
      [
        ['rocks', described_class::ROCKS],
        ['snow', described_class::SNOW],
        ['mountain', described_class::MOUNTAIN],
        ['desert', described_class::DESERT],
        ['grassland', described_class::GRASSLAND],
        ['valley', described_class::VALLEY],
        ['coastline', described_class::COASTLINE]
      ]
    end

    subject { biome }

    with_them do
      it { is_expected.to be_land }
      it { is_expected.not_to be_water }
    end
  end
end
