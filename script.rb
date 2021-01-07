module Enumerable
  def my_each(&block)
    each(&block)
    self
  end
end

p(1..10).my_each { |x| p x }
p([3, 4, 6, 9].my_each) { |x| p "we have #{x}" }
