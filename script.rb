module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item]) }
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item], item) }
  end
end

# p([1, 2, 3, 4, 5]).my_each { |x| p x }
# p([3, 4, 6, 9]).my_each_with_index { |item, index| p "we have index #{index} for array #{item}" }
