# frozen_string_literal: true

RSpec.describe Rekkyo::Type::Member do
  describe "#initialize" do
    subject { described_class.new(:RED, "#FF0000") }

    it { is_expected.to have_attributes key: :RED, value: "#FF0000" }
  end

  describe "#==" do
    subject { described_class.new(:RED, "#FF0000") == other }

    context "when same class, same key, same value specified" do
      let(:other) { described_class.new(:RED, "#FF0000") }

      it { is_expected.to be true }
    end

    context "when case of same class, other key, same value specified" do
      let(:other) { described_class.new(:red, "#FF0000") }

      it { is_expected.to be false }
    end

    context "when case of same class, same key, other value specified" do
      let(:other) { described_class.new(:RED, "RED") }

      it { is_expected.to be false }
    end

    context "when case of other class specified" do
      let(:other) { Struct.new(:key, :value).new(:RED, "#FF0000") }

      it { is_expected.to be false }
    end
  end

  describe "#match?" do
    subject { described_class.new(:RED, "RED").match?(other) }

    context "when same member specified" do
      let(:other) { described_class.new(:RED, "RED") }

      it { is_expected.to be true }
    end

    context "when same class but other member specified" do
      let(:other) { described_class.new(:BLUE, "BLUE") }

      it { is_expected.to be false }
    end

    context "when String class and same value specified" do
      let(:other) { "RED" }

      it { is_expected.to be true }
    end

    context "when String class and other value specified" do
      let(:other) { "BLUE" }

      it { is_expected.to be false }
    end

    context "when Symbol class and same value specified" do
      let(:other) { :RED }

      it { is_expected.to be true }
    end

    context "when Symbol class and other value specified" do
      let(:other) { :BLUE }

      it { is_expected.to be false }
    end

    context "when other class and same value specified" do
      let(:other) { "RED" }

      it { is_expected.to be true }
    end

    context "when other class and other value specified" do
      let(:other) { "BLUE" }

      it { is_expected.to be false }
    end
  end

  describe "#===" do
    subject { described_class.instance_method(:===) }

    it { is_expected.to eq described_class.instance_method(:match?) }
  end

  describe "#inspect" do
    subject { described_class.new(:RED, "#FF0000").inspect }

    it { is_expected.to eq 'Rekkyo::Type::Member::RED("#FF0000")' }
  end

  describe "#to_s" do
    subject { described_class.new(:RED, :"#FF0000").to_s }

    it { is_expected.to eq "#FF0000" }
  end

  if defined? ActiveSupport
    describe "#as_json" do
      let(:member) { described_class.new(:RED, +"RED") }

      it "delegates to `value.as_json`" do
        options = {}
        expect(member.value).to receive(:as_json).with(options).and_call_original
        expect(member.as_json(options)).to eq "RED"
      end
    end
  end
end
