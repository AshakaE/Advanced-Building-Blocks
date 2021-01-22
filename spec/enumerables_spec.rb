require './script'
require 'rspec'

RSpec.describe Enumerable do
  let(:arr) { [6, 4, 3, 5] }
  let(:range) { (1..8) }
  let(:string) { %w[red green factor] }
  let(:block) { proc { |num| num < 4 } }

  describe '#my_each' do
    context 'when no block is given' do
      it { is_expected.to be_truthy }
    end

    it 'returns the original array' do
      expect(string.my_each { |x| x }).to eq(string)
    end

    it 'prints result to stdout from block calculation' do
      expect { arr.my_each { |i| print i + 4 } }.to output(/10879/).to_stdout
    end

    it 'prints result to stdout from block calculation' do
      expect { arr.my_each { |i| print i - 4 } }.to output(/20-11/).to_stdout
    end

    it 'prints result to stdout with block given' do
      expect { string.my_each { |i| print i.length } }.to output(/356/).to_stdout
    end
  end

  describe '#my_each_with_index' do
    context 'when no block is given' do
      it { is_expected.to be_truthy }
    end

    it 'prints the element and corresponding index to stdout' do
      expect { arr.my_each_with_index { |x, i| print x, i } }.to output(/60413253/).to_stdout
    end

    it 'returns original array when no output' do
      expect(arr.my_each_with_index { block }).to eq(arr)
    end
  end

  describe '#my_select' do
    context 'when no block is given' do
      it { is_expected.to be_truthy }
    end

    it 'returns even numbers from array of numbers' do
      expect(arr.my_select(&:even?)).to eq([6, 4])
    end

    it 'returns odd numbers from array of numbers' do
      expect(arr.my_select(&:odd?)).to eq([3, 5])
    end
  end

  describe '#my_all?' do
    it 'should return true' do
      expect(arr.my_all?(&:odd?)).to be_falsy
    end

    it 'should return true' do
      expect(arr.my_all?(&:even?)).to be_falsy
    end

    it 'should return false' do
      expect(arr.my_all? { |n| n < 10 }).to be_truthy
    end

    it 'should return true' do
      expect(arr.my_all? { |n| n > 10 }).to be_falsy
    end
  end

  describe '#my_any?' do
    it 'should return true' do
      expect(arr.my_any?(&:odd?)).to be_truthy
    end

    it 'should return true' do
      expect(arr.my_any?(&:even?)).to be_truthy
    end

    it 'should return false' do
      expect(arr.my_any? { |n| n > 10 }).to be_falsy
    end

    it 'should return false' do
      expect(arr.my_any? { |n| n < 10 }).to be_truthy
    end
  end

  describe '#my_none?' do
    it 'should return false' do
      expect(arr.my_none?(&:odd?)).to be_falsy
    end

    it 'should return false' do
      expect(arr.my_none?(&:even?)).to be_falsy
    end

    it 'should return true' do
      expect(arr.my_none? { |n| n > 10 }).to be_truthy
    end

    it 'should return false' do
      expect(arr.my_none? { |n| n < 10 }).to be_falsy
    end

    it 'should return false' do
      expect([true, false, nil].my_none?).to be_falsy
    end

    it 'should return true' do
      expect([].my_none?).to be_truthy
    end

    it 'should return true' do
      expect(string.my_none?(/g/)).to be_falsy
    end

    it 'should return false' do
      expect(string.my_none?(/d/)).to be_falsy
    end
  end

  describe '#my_count?' do
    it 'returns the total no of elements in the array' do
      expect(arr.my_count).to eq(4)
    end

    it 'returns the total number of odd elements in the array' do
      expect(arr.my_count(&:odd?)).to eq(2)
    end

    it 'returns the total number of even elements in the array' do
      expect(arr.my_count(&:even?)).to eq(2)
    end

    it 'returns array length when no block is given' do
      expect(string.my_count).to eq(3)
    end

    it 'returns the number of items that match the positional argument given' do
      expect(string.my_count('green')).to eq(1)
    end
  end

  describe '#my_map' do
    it 'returns a modified array resulting from the block operation' do
      expect(arr.my_map { |n| 2 * n }).to eq([12, 8, 6, 10])
    end

    it 'returns modified array when given a range with a block' do
      expect(range.my_map { |n| n + 2 }).to eq([3, 4, 5, 6, 7, 8, 9, 10])
    end

    it 'returns modified array when given a range with a block' do
      expect(range.my_map { |n| n - 2 }).to eq([-1, 0, 1, 2, 3, 4, 5, 6])
    end

    it 'returns array of strings when given array of integers' do
      expect(arr.my_map(&:to_s)).to eq(%w[6 4 3 5])
    end
  end

  describe '#my_inject' do
    it 'returns the product when given a starting value and a block operation' do
      expect(arr.my_inject(1) { |product, n| product * n }).to eq(360)
    end

    it 'returns the product when given starting value and a unary operator' do
      expect(range.my_inject(1, :*)).to eq(40_320)
    end
  end
end
