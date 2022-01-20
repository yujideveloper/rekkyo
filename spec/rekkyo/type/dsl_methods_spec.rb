# frozen_string_literal: true

RSpec.describe Rekkyo::Type::DSLMethods do
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
        expect(m).to respond_to :red?
      end
    end

    context "when both key and value are specified" do
      it "defines member" do
        define(:RED, "#FF0000")

        m = dummy_class.const_get(:RED, false)
        expect(m).to be_a dummy_member_class
        expect(m).to have_attributes key: :RED, value: "#FF0000"
        expect(m).to respond_to :red?
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

    context "when multiple keys are registered" do
      it "defines multiple members" do
        define(:RED)
        define(:BLUE)

        red = dummy_class.const_get(:RED, false)
        expect(red).to be_red
        expect(red).not_to be_blue

        blue = dummy_class.const_get(:BLUE, false)
        expect(blue).not_to be_red
        expect(blue).to be_blue
      end
    end
  end
end
