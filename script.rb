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
end

# p([1, 2, 3, 4, 5]).my_each { |x| p x }
# p([3, 4, 6, 9]).my_each_with_index { |item, index| p "we have index #{index} for array #{item}" }

# friends = %w[Sharon Leo Leila Brian Arun]
# p friends.my_select { |friend| friend != 'Brian' }
