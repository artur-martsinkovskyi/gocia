# frozen_string_literal: true

describe ConstrainedParameter do
  let(:constrained_parameter) do
    ConstrainedParameter.new(
      lower_bound: lower_bound,
      upper_bound: upper_bound,
      value: value
    )
  end
  let(:lower_bound) { 0 }
  let(:upper_bound) { 10 }
  let(:value) { 0 }

  describe '#inc' do
    subject(:inc) { constrained_parameter.inc }

    it { expect { inc }.to change { constrained_parameter.value }.by(1) }

    context 'when value is equal to upper_bound' do
      let(:value) { upper_bound }

      it { expect { inc }.not_to(change { constrained_parameter.value }) }
    end

    context 'when #inc is called with a value' do
      let(:inc_value) { 3 }
      subject(:inc) { constrained_parameter.inc(inc_value) }

      it { expect { inc }.to change { constrained_parameter.value }.by(inc_value) }

      context 'when #inc is call with negative value' do
        let(:inc_value) { -3 }
        it 'works the same as with the positive' do
          expect { inc }.to change { constrained_parameter.value }.by(3)
        end
      end
    end
  end

  describe '#dec' do
    let(:value) { 3 }
    subject(:dec) { constrained_parameter.dec }

    it { expect { dec }.to change { constrained_parameter.value }.by(-1) }

    context 'when value is equal to lower_bound' do
      let(:value) { lower_bound }

      it { expect { dec }.not_to(change { constrained_parameter.value }) }
    end

    context 'when #dec is called with a value' do
      let(:dec_value) { 3 }
      subject(:dec) { constrained_parameter.dec(dec_value) }

      it { expect { dec }.to change { constrained_parameter.value }.by(-dec_value) }

      context 'when #dec is call with negative value' do
        let(:dec_value) { -3 }
        it 'works the same as with the positive' do
          expect { dec }.to change { constrained_parameter.value }.by(-3)
        end
      end
    end
  end

  describe '#set' do
    subject(:set) { constrained_parameter.set(set_value) }
    let(:set_value) { 4 }

    it { expect { set }.to change { constrained_parameter.value }.to(4) }

    context 'when parameter is off limits' do
      context 'when parameter is greater than upper_bound' do
        let(:set_value) { 12 }

        it { expect { set }.to raise_error(ArgumentError) }
      end

      context 'when parameter is less than lower_bound' do
        let(:set_value) { -12 }

        it { expect { set }.to raise_error(ArgumentError) }
      end
    end
  end
end
