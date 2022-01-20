# frozen_string_literal: true

RSpec.describe Rekkyo::Type::EnumMethods do
  let(:dummy_member_class) { Class.new(Rekkyo::Type::Member) }
  let(:dummy_class) do
    c = Class.new { @members = Set.new }
    c.const_set(:Member, dummy_member_class)
    c.extend described_class
    c
  end

  describe "#freeze" do
    it "freeze @members" do
      expect(dummy_class.instance_variable_get(:@members)).not_to be_frozen
      dummy_class.freeze
      expect(dummy_class.instance_variable_get(:@members)).to be_frozen
    end
  end
end
