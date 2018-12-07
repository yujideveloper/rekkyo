# frozen_string_literal: true

require "rekkyo/version"

module Rekkyo
  class Error < StandardError; end
  class DuplicateKeyError < Error
  end
end

require "rekkyo/type"
