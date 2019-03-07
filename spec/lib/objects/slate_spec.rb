describe Slate do
  describe ".new" do
    context "When height and moist is not given" do
      subject(:slate) { described_class.new(1, 1) }

      it "has height and moist set to 0" do
        expect(slate.height).to eq(0)
        expect(slate.moist).to eq(0)
      end
    end

    context "When height is > 0.9" do
      subject(:slate) { described_class.new(1, 1, 0.95, 0) }

      it "has tree in contents" do
        expect(slate.contents).to include(instance_of(Tree))
      end
    end
  end
end
