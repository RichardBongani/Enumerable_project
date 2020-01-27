module Enumerable

  def my_each
    if block_given?
      (0..length - 1).each do |i|
        yield(self[i])
      end
      self
    else
      Enumerable
    end
  end

  def my_each_with_index
    if block_given?
      (0..length - 1).each do |i|
        yield(self[i], i)
      end
    else
      Enumerable
    end
  end

  def my_select
    arr = []
    if block_given?
      (1..length - 1).each do |i|
        arr.push(self[i]) if yield(self[i])
      end
    else
      Enumerable
    end
    arr
  end

  def my_all?
    results = true
    (0..length - 1).each do |i|
      results = yield(self[i])
      break unless results
    end
    results
  end

  def my_any?
    results = false
    (0..length - 1).each do |i|
      results = true if yield(self[i])
    end
    results
  end

  def my_none?
    res = true
    if block_given?
      (0..length - 1).each do |i|
        res = yield(self[i])
        break
      end
    end
    !res
  end

  def my_count
    counter = 0
    (0..length - 1).each do |i|
      counter += 1 if yield(self[i])
    end
    counter
  end

  def my_map(proc = nil)
    arr = []
    (0..length - 1).each do |i|
      if proc
        arr.push(proc.call(self[i]))
      else
        arr.push(yield self[i])
      end
    end
    arr
  end

  def my_inject
    injection = self[0]
    slice(1, length - 1).my_each do |item|
      injection = yield(item, injection)
    end
    injection
  end
end

def multiply_els(arr)
  arr.my_inject { |number1, number2| number1 * number2 }
end

my_proc = proc { |x| x }

[1, 2, 3, 4, 5].my_each { |x| p x }
[1, 2, 3, 4, 5].my_each_with_index { |value, index| p "#{index} with a value of #{value}" }
p [1, 2, 3, 4, 8].my_select(&:even?)
p [1, 2, 6, 4, 5].my_all? { |element| element < 15 }
p [1, -2, 3, 4, 5].my_any?(&:negative?)
p [4, 4, 6, 4, 10].my_none? { |element| element > 100 }
p [1, 2, 3, 4, 6].my_count { |item| (item % 3).zero? }
p [1, 2, 3, 4, 5].my_map { |number| number * number }
p [1, 2, 3, 4, 5].my_map(&my_proc)
p [2, 4, 5].my_inject { |total, num1| total * num1 }
p multiply_els([2, 4, 5])
