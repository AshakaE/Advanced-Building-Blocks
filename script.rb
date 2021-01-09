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

  def my_all?(arg = nil)
    condition = true
    if arg
      my_each { |item| return false unless arg === item } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |item| return false unless yield(item) }
    else
      my_each { |item| return false unless item }
    end
    condition
  end

  def my_any?(arg = nil)
    condition = false
    if arg
      my_each { |item| return true if arg === item } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |item| return true if yield(item) }
    else
      my_each { |item| return true if item }
    end
    condition
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_count(value = nil, &block)
    if block_given?
      my_select(&block).size
    elsif !value.nil?
      my_select { |n| n == value }.size
    else
      size
    end
  end

  def my_map(proc = nil)
    return to_enum(:map) unless block_given?

    arr = []
    my_each do |item|
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
