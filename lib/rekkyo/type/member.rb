# frozen_string_literal: true

module Rekkyo
  module Type
    class Member
      attr_reader :key, :value

      def initialize(key, value)
        @key = key
        @value = value
      end

      def ==(other)
        self.class == other.class &&
          self.key == other.key &&
          self.value == other.value
      end

      def match?(other)
        case other
        when self.class
          self == other
        when String, Symbol
          self.value.to_s == other.to_s
        else
          self.value == other
        end
      end

      alias === match?

      def inspect
        "#{self.class.name || ''}::#{key}(#{value.inspect})"
      end

      def to_s
        self.value.to_s
      end

      if defined? ActiveSupport
        def as_json(options = nil)
          self.to_s.as_json(options)
        end
      end
    end
  end
end
