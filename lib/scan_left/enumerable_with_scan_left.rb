# frozen_string_literal: true

# This refines `Enumerable` to add a `#scan_left` method. This allows
# for a more natural syntax than explicitly using the `ScanLeft`
# class.
#
# Without using this refinement:
# ScanLeft.new([1,2,3]).scan_left(0, &:+) => [0, 1, 3, 6]
#
# Using this refinement:
# [1,2,3].scan_left(0, &:+)               => [0, 1, 3, 6]
#
#
# Example:
#
# class Foo
#   using EnumerableWithScanLeft
#
#   def bar(x)
#     [1,2,3].scan_left(x, &:+)
#   end
# end
#
# Foo.new.bar(10) => [10, 11, 13, 16]
module EnumerableWithScanLeft
  refine Enumerable do
    def scan_left(initial, &block)
      ScanLeft.new(self).scan_left(initial, &block)
    end
  end
end
