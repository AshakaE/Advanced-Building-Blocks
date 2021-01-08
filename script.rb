module Enumerable
  def to_enumerable
    return to_enum unless block_given?
  end

  def my_each
    to_enumerable

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item]) }
  end

  def my_each_with_index
    to_enumerable

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item], item) }
  end

  def my_select
    new_arr = []
    to_enumerable

    my_each { |m| new_arr << m if yield(m) }
    new_arr
  end

  def my_all?
    condition = true
    my_each do |item|
      condition = false if (block_given? && !yield(item)) || (!block_given? && !item)
    end
    condition
  end

  def my_any?
    condition = false
    my_each do |item|
      condition = true if (block_given? && yield(item)) || (!block_given? && item)
    end
    condition
  end
end

# p([1, 2, 3, 4, 5]).my_each { |x| p x }
# p([3, 4, 6, 9]).my_each_with_index { |item, index| p "we have index #{index} for array #{item}" }
# state = %w[ant bear cat ja]
# p state.my_any? { |word| word.length < 3 }
# p state.my_any?
# friends = %w[Sharon Leo Leila Brian Arun]
# p friends.my_select { |friend| friend != 'Brian' }
