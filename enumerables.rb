module Enumerable

  def my_each
    return p to_enum(__method__) unless block_given?
      i = 0
      while i < self.size
        yield(self[i])
        i += 1
      end
      return to_enum
  end

  def my_each_with_index
      if block_given?
        i = 0
        my_each do
          yield(self[i], i)
          i += 1
        end
      else
        return to_enum(__method__)
      end
    end

  def my_select
    return p to_enum(__method__) unless block_given?
      array = []
      i = 0
      while i < self.size
          array << self[i] if yield(self[i])
          i +=1                
      end
      array
  end

  def my_all?(pattern = nil) #(true) if  block never ret. false or nil
      method_all = true
      if block_given? # this makes sure that our program does not crash if my_all doesnt have a block
        my_each do |i| # for each element in the array.
          method_all = false unless yield i # return false if all the elements in a block evaluates to false
        end
        elsif pattern
        my_each do |i| 
          method_all = false unless pattern === i 
        end
      else
        my_each do |i|
          method_all = false unless i
        end
      end
      method_all
    end

  def my_any?(pattern = nil) #(true) if  block ever returns val other than false/nil
      method_any = false
      if block_given? # this makes sure that my_any does not crash  if we dont give it a block
          my_each do |element| # iterate through each element in an array
            method_any = true if yield element # return true  if any of the elements in the block evaluates to true
          end
      elsif pattern
          my_each do |element|
            method_any = true if pattern === element
          end
      else
          my_each do |element| 
            method_any = true if element
          end
      end
      method_any
  end

  def my_none?(pattern = nil)
      method_none = true
      if block_given?
          my_each  do |i| 
            method_none = false if yield i #resturns false if none of the elements evauluates to true
          end
      elsif pattern
          my_each do |i| 
            method_none = false if pattern === i
          end
      else
          my_each do |i| 
            method_none = false if i
          end
      end
      method_none
  end

  def my_count(answer = nil, &block)
      method_count = 0
      if block && !answer
        my_each do |n| 
          method_count += 1 if yield(n)
        end
      elsif !answer
        my_each do |n|
          method_count += 1
        end
      else
        my_each do |n| 
          method_count += 1 if answer == n
        end
      end
      method_count
    end

    def my_inject(*args)
      raise 'no block_given' if !block_given? && args.nil?
      array = to_a
      memo = args[0] || array[0]
      if block_given? && args.empty?
        array.my_each_with_index do |item, index|
          next if index.zero?
          memo = yield(item, memo)
        end
      elsif block_given? && args[0]
        memo = args[0]
        array.my_each do |item|
          memo = yield(item, memo)
        end
      elsif args[0].is_a? Symbol
        memo = array[0]
        array.my_each_with_index do |item, index|
          next if index.zero?
          memo = memo.send(args[0], item)
        end
      else
        memo = args[0]
        array.my_each_with_index do |item, _index|
          memo = memo.send(args[1], item)
        end
      end
      memo
    end
  
    def multiply_els(array)
      array.my_inject(1) do |index, value|
        index * value
      end
    end
  
    def my_map(&block)
      if block_given? #this makes sure that our map does not crash if any block is not given
        result = [] #empty array that will store an array based on the conditions 
        if block.nil?
          return result
        elsif
          my_each {|item| result << yield(item)}
        end
        result
      else
        return to_enum(__method__)
      end
    end
end