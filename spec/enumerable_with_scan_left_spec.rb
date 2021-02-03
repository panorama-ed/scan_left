# frozen_string_literal: true

require "scan_left_examples"

RSpec.describe EnumerableWithScanLeft do
  using described_class

  subject { enumerable.scan_left(initial, &block) }

  # There is a bug in Ruby 2.7 that prevents these specs from passing. See:
  #   * https://github.com/rspec/rspec-core/issues/2727
  #   * https://bugs.ruby-lang.org/issues/16852
  #
  # Until this is resolved, we skip these specs on Ruby 2.7.
  pending_msg = "Known bug in Ruby 2.7" if RUBY_VERSION.start_with?("2.7")
  include_examples "scan_left_examples", skip: pending_msg
end
