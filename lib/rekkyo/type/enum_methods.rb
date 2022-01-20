# frozen_string_literal: true

module Rekkyo
  module Type
    module EnumMethods
      def all
        @members.dup
      end

      alias members all

      def freeze
        @members.freeze
        super
      end
    end
  end
end
