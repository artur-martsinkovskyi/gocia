describe Slate do
  describe ".new" do
    context "When height and moist is not given" do
      subject(:slate) { described_class.new(1, 1) }

      it "has height and moist set to 0" do
        expect(slate.height).to eq(0)
        expect(slate.moist).to eq(0)
      end
    end
  end
end
