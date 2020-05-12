# frozen_string_literal: true

require "scan_left_examples"

RSpec.describe ScanLeft do
  subject { described_class.new(enumerable).scan_left(initial, &block) }

  include_examples "scan_left_examples"
end
