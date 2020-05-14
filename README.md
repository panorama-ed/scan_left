# scan_left
![Tests](https://github.com/panorama-ed/scan_left/workflows/Tests/badge.svg)

[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/panorma-ed/scan_left)
[![Docs Coverage](http://inch-ci.org/github/panorama-ed/scan_left.png)](http://inch-ci.org/github/panorama-ed/scan_left)

[![Gem Version](https://img.shields.io/gem/v/scan_left.svg)](https://rubygems.org/gems/scan_left)
[![Gem Downloads](https://img.shields.io/gem/dt/scan_left.svg)](https://rubygems.org/gems/scan_left)

A tiny Ruby gem to provide the `#scan_left` operation on any Ruby
`Enumerable`.

## What does it do?

Imagine a series of numbers which you want to *sum*. You accomplish
this by processing all elements, adding each to the previous sum,
returning the final result.

Now imagine that, rather than just the final sum at the end of the
series, you want *a series* of the partial sums after processing each
element. This is called a ["Prefix
Sum"](https://en.wikipedia.org/wiki/Prefix_sum).

In functional programming (FP), the *sum* is generalized as the *fold*
operation, in which an initial state and a binary operation are
combined to "fold" a series of values into a single result. The
closely related *prefix sum*, which produces a series of intermediate
results, is generalized as the *scan* operation. Adding "left" to
these operation names indicates that calculation is to proceed
left-to-right.

## Compare / Contrast with #inject

Ruby's standard library operation `Enumerable#inject` implements the
FP fold operation. It also implements the simpler reduce operation,
which is a fold whose initial state is the first element of the
series.

The key differences between `#inject` and `#scan_left` are:

  1. **Incremental results**: `#scan_left` returns a series of results
     after processing each element of the input series. `#inject`
     returns a single value, which equals the final result in the
     series returned by `#scan_left`.

  2. **Laziness**: `#scan_left` can preserve the laziness of the input
     series.  As each incremental result is read from the output
     series, the actual calculation is lazily performed against the
     input. `#inject` cannot be a a lazy operation in general, as its
     single result reflects a calculation across every element of the
     input series.

## Examples

```ruby
require "scan_left"

# For comparison, results from #inject are included as well.

ScanLeft.new([]).scan_left(0) { |s, x| s + x } == [0]
[].inject(0) { |s, x| s + x }                  == 0

ScanLeft.new([1]).scan_left(0) { |s, x| s + x } == [0, 1]
[1].inject(0) { |s, x| s + x }                  == 1

ScanLeft.new([1, 2, 3]).scan_left(0) { |s, x| s + x } == [0, 1, 3, 6]
[1, 2, 3].inject(0) { |s, x| s + x }                  == 6

# To avoid explicitly using the `ScanLeft` class you can use the
# provided refinement on Enumerable. This adds `#scan_left` directly
# to Enumerable for a more concise syntax.
using EnumerableWithScanleft

[].scan_left(0) { |s, x| s + x }        => [0]
[1].scan_left(0) { |s, x| s + x }       => [0, 1]
[1, 2, 3].scan_left(0) { |s, x| s + x } => [0, 1, 3, 6]
```

## Further Reading

  * https://en.wikipedia.org/wiki/Fold_(higher-order_function)
  * https://en.wikipedia.org/wiki/Prefix_sum#Scan_higher_order_function
  * http://alvinalexander.com/scala/how-to-walk-scala-collections-reduceleft-foldright-cookbook#scanleft-and-scanright
