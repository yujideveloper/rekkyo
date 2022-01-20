# frozen_string_literal: true

module Rekkyo
  module Type
    module DSLMethods
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

      private

      def validate_member(key, value)
        raise DuplicateMemberError if self.const_defined?(key, false) ||
                                      @members.any? { |m| m.match? value }
      end
    end
  end
end
