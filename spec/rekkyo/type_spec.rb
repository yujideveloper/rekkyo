# frozen_string_literal: true

RSpec.describe Rekkyo::Type do
  describe Rekkyo::Type::Member do
    describe "#match?" do
      subject { described_class.new(:RED, "RED").match?(other) }

      context "in same member" do
        let(:other) { described_class.new(:RED, "RED") }

        it { is_expected.to be true }
      end

      context "in same class but other member" do
        let(:other) { described_class.new(:BLUE, "BLUE") }

        it { is_expected.to be false }
      end

      context "in other class and same value" do
        let(:other) { "RED" }

        it { is_expected.to be true }
      end

      context "in other class and other value" do
        let(:other) { "BLUE" }

        it { is_expected.to be false }
      end
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

  describe Rekkyo::Type::ClassMethods do
    let(:dummy_member_class) { Class.new(Rekkyo::Type::Member) }
    let(:dummy_class) do
      c = Class.new { @members = Set.new }
      c.const_set(:Member, dummy_member_class)
      c.extend described_class
      c
    end

    describe "#member" do
      def define(*args)
        dummy_class.instance_exec do
          member(*args)
        end
      end

      context "when only a key is specified" do
        it "defines member" do
          define("red")

          m = dummy_class.const_get(:RED, false)
          expect(m).to be_a dummy_member_class
          expect(m).to have_attributes key: :RED, value: "red"
        end
      end

      context "when both key and value are specified" do
        it "defines member" do
          define(:RED, "#FF0000")

          m = dummy_class.const_get(:RED, false)
          expect(m).to be_a dummy_member_class
          expect(m).to have_attributes key: :RED, value: "#FF0000"
        end
      end

      context "when already defined key is specified" do
        it "raises DuplicateMemberError" do
          define(:RED)

          expect { define(:RED) }.to raise_error Rekkyo::DuplicateMemberError
        end
      end

      context "when already defined value is specified" do
        it "raises DuplicateMemberError" do
          define(:RED, "foo")

          expect { define(:BLUE, "foo") }.to raise_error Rekkyo::DuplicateMemberError
        end
      end
    end
  end

  describe ".included" do
    let(:dummy_class) { Class.new.include described_class }

    describe "@members" do
      subject { dummy_class.instance_variable_get(:@members) }

      it { is_expected.to be_a Set }
      it { is_expected.to be_empty }
    end

    describe "Member" do
      subject { dummy_class.const_get(:Member, false) }

      it { is_expected.to be < Rekkyo::Type::Member }
    end

    describe "class methods" do
      subject { dummy_class.singleton_class }

      it { is_expected.to include Rekkyo::Type::ClassMethods }
    end
  end
end
