# frozen_string_literal: true

require "set"

module Rekkyo
  module Type
    Member = Struct.new(:key, :value) do
      def match?(value)
        if value.is_a? self.class
          self == value
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

        raise DuplicateMemberError if self.const_defined?(key, false) ||
                                      @members.any? { |m| m.match? value }

        m = self::Member.new(key, value).freeze
        @members << m
        self.const_set(key, m)
      end

      def all
        @members.dup
      end

      alias members all
    end
  end
end
