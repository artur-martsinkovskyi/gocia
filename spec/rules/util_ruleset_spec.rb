# frozen_string_literal: true

describe UtilRuleset do
  describe '#satisfies?' do
    subject { described_class.satisfies?(rule).call(object) }
    let(:rule) do
      proc do |obj|
        if obj
          double(
            success?: true,
            failure?: false
          )
        else
          double(
            success?: false,
            failure?: true
          )
        end
      end
    end

    context 'when object satisfies a rule' do
      let(:object) { Object.new }

      it { is_expected.to eq(true) }
    end

    context 'when object does not satisfy a rule' do
      let(:object) { nil }

      it { is_expected.to eq(false) }
    end
  end

  describe '#dissatisfies?' do
    subject { described_class.dissatisfies?(rule).call(object) }
    let(:rule) do
      proc do |obj|
        if obj
          double(
            success?: true,
            failure?: false
          )
        else
          double(
            success?: false,
            failure?: true
          )
        end
      end
    end

    context 'when object satisfies a rule' do
      let(:object) { Object.new }

      it { is_expected.to eq(false) }
    end

    context 'when object does not satisfy a rule' do
      let(:object) { nil }

      it { is_expected.to eq(true) }
    end
  end
end
