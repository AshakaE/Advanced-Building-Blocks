module Enumerable
  def my_each
    return to_enum(:each) unless block_given?

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

  def my_all?(_arg = nil)
    condition = true
    my_each do |item|
      condition = false if _arg (block_given? && !yield(item)) || (!block_given? && !item)
    end
    condition
  end

  def my_any?(_arg = nil)
    condition = false
    my_each do |item|
      condition = true if _arg (block_given? && yield(item)) || (!block_given? && item)
    end
    condition
  end

  def my_none?(_arg = nil)
    condition = true
    my_each do |item|
      condition = false if _arg (block_given? && yield(item)) || (!block_given? && item)
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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_inject(prime = nil, meth = nil)
    if (prime && meth.nil?) && (prime.is_a?(Symbol) || prime.is_a?(String))
      meth = prime
      prime = nil
    end

    if !block_given? && meth
      to_a.my_each { |item| prime = prime ? prime.send(meth, item) : item }
    else
      to_a.my_each { |item| prime = prime ? yield(prime, item) : item }
    end
    prime
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

def multiply_els(array)
  array.my_inject { |quotient, x| quotient * x }
end
