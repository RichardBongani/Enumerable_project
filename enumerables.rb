module Enumerable

    def my_each
        if block_given?
            for i in 0..self.length-1
                yield(self[i])
            end
            self
        else
            return Enumerable
        end
    end
    
    def my_each_with_index
        if block_given?
            for i in 0..self.length-1
                yield(self[i],i)
            end
        else
            return Enumerable
        end
    # end

    def my_select
        arr = []
        if block_given?
            for i in 1..self.length-1
                if yield(self[i])
                    arr.push(self[i])
                end
            end
        else
            return Enumerable
        end
        arr
    end

    def my_all?(&block)
        for i in 0..self.length-1
            if yield(self[i])
                returns true
            else
                returns false
            end
        end
        results
    end

    def my_any?
        results = false
        for i in 0..self.length-1
            if yield(self[i])
                results = true
            end
        end
        results
    end

    def my_none?
        for i in 0..self.length-1
            if yield(self[i])
                return false
            end
        end
        return true
    end

    def my_count
        counter = 0
        for i in 0..self.length-1
            if yield(self[i])
                counter +=1
            end
        end
        counter
    end

    def my_map(proc= nil)
        array = []
        for i in 1..self.length
            yield(self[i])
            array.push(i)
        end
        array
    end
    
    def my_inject(total = nil)
        total = self[0] unless total
        for a in 1..self.length - 1
            num1 = self[a]
            total = yield total,num1
        end
        total
    end

end

def multiply_els(arr)
    arr.my_inject( :*)
end

my_proc = Proc.new{|x| x}

[1,2,3,4,5].my_each {|x| p x}
[1,2,3,4,5].my_each_with_index {|value,index| p "#{index} with a value of #{value}"}
p [1,2,3,4,8].my_select {|item| item % 2 == 0}
[1,2,6,4,5].my_all?{|element| p element > 0}
[1,2,3,4,5].my_any?{|item| p item > 10}
[1,2,3,4,5].my_none?{|element| p element.even?}
p [1,2,3,4,5].my_count{|item| item < 5}
p [1,2,3,4,5].my_map{|x|  x }
p [1,2,3,4,5].my_map(&my_proc)
[2,4,5].my_inject{|total,num1| p total*num1}

