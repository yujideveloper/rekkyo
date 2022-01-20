# frozen_string_literal: true

RSpec.describe Rekkyo::Type do
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

    describe "dsl methods" do
      subject { dummy_class.singleton_class }

      it { is_expected.to include Rekkyo::Type::DSLMethods }
    end

    describe "enum methods" do
      subject { dummy_class.singleton_class }

      it { is_expected.to include Rekkyo::Type::EnumMethods }
    end
  end
end
