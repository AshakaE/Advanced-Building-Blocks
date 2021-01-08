module Enumerable
  def my_each
    return to_enum(:each) unless block_given?

    # arr = self if instance_of?(Array)
    arr ||= to_a
    arr.length.times { |item| yield(arr[item]) }
    self
  end

  def my_each_with_index
    return to_enum(:each_with_index) unless block_given?

    arr ||= to_a
    arr.length.times { |item| yield(arr[item], item) }
    self
  end

  def my_select
    return to_enum(:select) unless block_given?

    new_arr = []

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

  def my_count(value = nil, &block)
    if block_given?
      my_select(&block).size
    elsif !value.nil?
      my_select { |n| n == input }.size
    else
      size
    end
  end

  def my_map(proc = nil)
    arr = to_a
    arr.my_each do |item|
      arr << if proc
               proc.call(item)
             else
               yield(item)
             end
    end
    arr
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


