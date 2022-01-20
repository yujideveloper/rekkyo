# frozen_string_literal: true

require "set"

module Rekkyo
  module Type
    class << self
      def included(klass)
        super
        klass.const_set(:Member, Class.new(Member))
        klass.instance_variable_set(:@members, Set.new)
        klass.extend(DSLMethods)
        klass.extend(EnumMethods)
      end

    end
  end
end

require "rekkyo/type/member"
require "rekkyo/type/dsl_methods"
require "rekkyo/type/enum_methods"
