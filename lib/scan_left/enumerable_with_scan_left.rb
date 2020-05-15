# frozen_string_literal: true

# *Optional*
# {refinement}[https://docs.ruby-lang.org/en/2.7.0/syntax/refinements_rdoc.html]
# which refines +Enumerable+ to add a +#scan_left+ method, in order to provide
# a more natural syntax in comparison to explicitly creating instances of the
# +ScanLeft+ class.
#
# Without using this refinement, we wrap Enumerables in +ScanLeft+ instances:
#
#   ScanLeft.new([1,2,3]).scan_left(0, &:+)  # => [0, 1, 3, 6]
#
# Using this refinement, we can call +#scan_left+ directly on any Enumerable:
#
#   [1,2,3].scan_left(0, &:+)                # => [0, 1, 3, 6]
#
# @example
#   class Foo
#     using EnumerableWithScanLeft
#
#     def bar(x)
#       [1,2,3].scan_left(x, &:+)
#     end
#   end
#
#   Foo.new.bar(10)  # => [10, 11, 13, 16]
#
module EnumerableWithScanLeft
  refine Enumerable do
    def scan_left(initial, &block)
      ScanLeft.new(self).scan_left(initial, &block)
    end
  end
end
