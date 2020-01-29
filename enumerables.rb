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

  def my_all?(pattern = nil)
      all = true
      if block_given?
        my_each do |i|
          all = false unless yield i
        end
      elsif pattern
        my_each do |i| 
          all = false unless pattern === i 
        end
      else
        my_each do |i|
          all = false unless i
        end
      end
      all
    end

  def my_any?(pattern = nil)
      any = false
      if block_given?
          my_each do |element| 
            any = true if yield element
          end
      elsif pattern
          my_each do |element|
            any = true if pattern === element
          end
      else
          my_each do |element| 
            any = true if element
          end
      end
      any
  end

  def my_none?(pattern = nil)
      none = true
      if block_given?
          my_each {|i| none = false if yield i}
      elsif pattern
          my_each {|i| none = false if pattern === i}
      else
          my_each {|i| none = false if i}
      end
      none
  end

  def my_count(answer = nil, &block)
      result = 0
      if block && !answer
        my_each { |n| result += 1 if yield(n) }
      elsif !answer
        my_each { result += 1 }
      else
        my_each { |n| result += 1 if answer == n }
      end
      result
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
      if block_given?
        result = []
        if block.nil?
          return result
        else
          my_each do |item|
            result << block.call(item)
          end
        end
  
        result
      else
        return to_enum(__method__)
      end
    end
end