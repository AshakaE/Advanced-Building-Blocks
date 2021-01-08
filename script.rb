module Enumerable
  def my_each
    return to_enum(:each) unless block_given?

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item]) }
    self
  end

  def my_each_with_index
    return to_enum(:each_with_index) unless block_given?

    arr = self if instance_of?(Array)
    arr.length.times { |item| yield(arr[item], item) }
    self
  end

  def my_select
    new_arr = []
    return to_enum(:select) unless block_given?

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

  def my_none?
    condition = true
    my_each do |item|
      condition = false if (block_given? && yield(item)) || (!block_given? && item)
    end
    condition
  end

  def my_count
    return size unless block_given?

    count = 0
    my_each do |item|
      count += 1 if yield(item)
    end
    count
  end

  def my_map(input)
    arr = to_a
    new_map = []
    arr.my_each do |item|
      new_map << if block_given?
                   yield(input.call(item))
                 else
                   input.call(item)
                 end
    end
    new_map
  end

  def my_inject(prime = nil)
    if !prime.nil?
      stack = prime
      my_each do |n|
        stack = yield(stack, n)
      end
    else
      stack = self[0]
      my_each_with_index do |_n, i|
        stack = yield(stack, self[i + 1]) if i < length - 1
      end
    end
    stack
  end
end

def multiply_els(array)
  array.my_inject { |quotient, x| quotient * x }
end

p [3, 4, 6, 9].my_each_with_index { |x, i| p "we have index of #{i} for case #{x}"}