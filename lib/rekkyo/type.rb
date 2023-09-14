# frozen_string_literal: true

require "set"
require "singleton"
require "forwardable"

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

      def create(member_names, freeze: true)
        ::Class.new do
          include ::Singleton
          extend ::SingleForwardable

          include EnumMethods
          def_single_delegators :instance, :all, :members

          const_set(:Member, ::Class.new(Member))

          define_method :initialize do
            member_class = self.class.const_get(:Member, false)
            @members = ::Set.new
            member_names.each do |member_name|
              member = member_class.new(member_name.upcase.to_sym, member_name).freeze
              @members << member
              self.class.const_set(member.key, member)
            end
          end

          instance # define a class and instantiate it
          instance.freeze if freeze
        end
      end
    end
  end
end

require "rekkyo/type/member"
require "rekkyo/type/dsl_methods"
require "rekkyo/type/enum_methods"
