module Enumerable
  def my_each
    for i in self
      yield(i)
    end
    self
  end
end

p(1..10).my_each { |x| p x }
p([3, 4, 6, 9]).my_each { |x| p "we have #{x}" }
