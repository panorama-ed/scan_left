# frozen_string_literal: true

require "scan_left_examples"

RSpec.describe EnumerableWithScanLeft do
  using described_class

  subject { enumerable.scan_left(initial, &block) }

  include_examples "scan_left_examples"
end
