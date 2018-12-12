# frozen_string_literal: true

require "set"

module Rekkyo
  module Type
    Member = Struct.new(:key, :value) do
      def match?(value)
        case value
        when self.class
          self == value
        when String, Symbol
          self.value.to_s == value.to_s
        else
          self.value == value
        end
      end

      alias_method :===, :match?

      def to_s
        self.value.to_s
      end

      if defined? ActiveSupport
        def as_json(options = nil)
          self.to_s.as_json(options)
        end
      end
    end

    class << self
      def included(klass)
        klass.const_set(:Member, Class.new(Member))
        klass.instance_variable_set(:@members, Set.new)
        klass.extend(ClassMethods)
      end
    end

    module ClassMethods
      UNSPECIFIED = Object.new.freeze
      private_constant :UNSPECIFIED

      def member(key, value = UNSPECIFIED)
        value = key if value == UNSPECIFIED
        key = key.upcase.to_sym

        validate_member(key, value)

        self::Member.new(key, value).freeze.tap do |m|
          @members << m

          self.const_set(key, m)

          self::Member.class_exec do
            define_method(:"#{key.downcase}?") { self.match?(m) }
          end
        end
      end

      def all
        @members.dup
      end

      alias members all

      private

      def validate_member(key, value)
        raise DuplicateMemberError if self.const_defined?(key, false) ||
                                      @members.any? { |m| m.match? value }
      end
    end
  end
end
