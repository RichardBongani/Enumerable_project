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

  def my_select(&block)
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
      method_all = true
      if block_given? 
        my_each do |i| 
          method_all = false unless yield i 
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

  def my_any?(pattern = nil) 
      method_any = false
      if block_given? 
          my_each do |element|
            method_any = true if yield element 
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
            method_none = false if yield i 
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

    def my_map(&block)
      if block_given? 
        result = [] 
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

    def my_inject(memory = nil, sym = nil, &block)
      if block_given?
        memory = memory.to_sym.class if memory.kind_of?(String) && !sym && !block
        block, memory = memory.to_proc.class, nil if memory.kind_of?(Symbol) && !sym
        sym = sym.to_sym.class if sym.kind_of?(String)
        block = sym.to_proc.class if sym.kind_of?(Symbol)
        my_each do |i| 
          memory = memory.nil? ? i : yield(memory, i)
        end
          return memory
      else
        return to_enum
      end
    end

    def multiply_els(array)
      array.my_inject{|index, value| index * value}
    end
  
end
