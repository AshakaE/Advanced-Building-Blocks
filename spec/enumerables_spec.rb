require './script'
require 'rspec'

RSpec.describe Enumerable do
  let(:arr) { [6, 4, 3, 5] }
  let(:range) { (1..8) }
  let(:string) { %w[red green factor] }
  let(:block) { proc { |num| num < 4 } }

  describe "#my_each" do
    context 'when no block is given' do
      it { is_expected.to be_truthy }
    end

    it 'returns the original array' do
      expect(string.my_each { |x| x }).to eq(string)
    end

    it 'prints result to stdout from block calculation' do
      expect { arr.my_each { |i| print i + 4 } }.to output(/10879/).to_stdout
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
end