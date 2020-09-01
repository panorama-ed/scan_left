# frozen_string_literal: true

RSpec.shared_examples "scan_left_examples" do |skip: false|
  # Uses the following lets:
  #   - enumerable  The stream to transform
  #   - initial     The initial value to use
  #   - block       The binary operation to use
  shared_examples "a_series_of_injects" do
    let(:series_of_intermediate_inject_results) do
      slices = (0..enumerable.size).map { |n| enumerable.take(n) }
      slices.map { |slice| slice.inject(initial, &block) }
    end

    it "equals a series of intermediate results from #inject" do
      expect(subject.to_a).to eq series_of_intermediate_inject_results
    end

    it "preserves laziness" do
      if enumerable.is_a?(Enumerator::Lazy)
        is_expected.to be_a(Enumerator::Lazy)
      else
        is_expected.not_to be_a(Enumerator::Lazy)
      end
    end
  end

  context "when summing ints", skip: skip do
    let(:initial) { 0 }
    let(:block) { ->(memo, obj) { memo + obj } }

    context "with zero elements" do
      let(:enumerable) { [] }

      it_behaves_like "a_series_of_injects"
    end

    context "with a single element" do
      let(:enumerable) { [1] }

      it_behaves_like "a_series_of_injects"
    end

    context "with multiple elements" do
      let(:enumerable) { (1..5).to_a }

      it_behaves_like "a_series_of_injects"

      context "when lazy" do
        let(:enumerable) { super().lazy }

        it_behaves_like "a_series_of_injects"
      end
    end
  end

  context "when using #with_index", skip: skip do
    let(:initial) { 0 }
    let(:enumerable) { [1, 2, 3].each.with_index }
    let(:block) { ->(memo, obj, index) { memo + obj + index } }

    it "passes the correct number of arguments to produce the correct result" do
      expect(subject).to eq([0, 1, 4, 9])
    end
  end
end
