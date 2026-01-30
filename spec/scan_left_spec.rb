# frozen_string_literal: true

require "scan_left_examples"

RSpec.describe ScanLeft do
  subject { described_class.new(enumerable).scan_left(initial, &block) }

  it_behaves_like "scan_left_examples"
end
