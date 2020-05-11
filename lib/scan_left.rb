# frozen_string_literal: true

# Original author: [Marc Siegel](https://github.com/ms-ati).
require "scan_left/version"

# Provides the {#scan_left} operation on any Enumerable.
class ScanLeft
  # @return [Enumerable]  Stream to transform via {#scan_left}
  attr_reader :enumerable

  # @param [Enumerable]  enumerable  Stream to transform via {#scan_left}
  def initialize(enumerable)
    @enumerable = enumerable
  end

  # Map the enumerable to the incremental state of a calculation by
  # applying the given block, in turn, to each element and the
  # previous state of the calculation, resulting in an enumerable of
  # the state after each iteration.
  #
  # @return [Enumerable] Generate a stream of intermediate states
  #   resulting from applying a binary operator. Equivalent to a
  #   stream of +#inject+ calls on first N elements, increasing N from
  #   zero to the size of the stream. NOTE: Preserves laziness if
  #   +enumerable+ is lazy.
  #
  # @param initial [Object] Initial state value to yield.
  #
  # @yield [memo, obj] Invokes given block with previous state value
  #   +memo+ and next element of the stream +obj+.
  #
  # @yieldreturn [Object] The next state value for +memo+.
  def scan_left(initial)
    memo = initial
    outs = enumerable.map { |*obj| memo = yield(memo, *obj) }
    prepend_preserving_laziness(value: initial, enum: outs)
  end

  private

  def prepend_preserving_laziness(value:, enum:)
    case enum
    when Enumerator::Lazy
      [[value], enum].lazy.flat_map { |x| x }
    else
      [value] + enum
    end
  end
end
