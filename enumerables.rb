module Enumerable

    def my_each
        for i in 0..self.length-1
            yield(self[i])
        end
    end
    
    def my_each_with_index
        for i in 0..self.length-1
            yield(self[i],i)
        end
    end

    def my_select
        arr = []
        for i in 1..self.length
            if yield(i)
                arr.push(i)
            end
        end
        arr
    end

    def my_all?
        results = true
        for i in 0..self.length-1
            if yield(self[i])
                results = true
            end
        end
        results
    end

    def my_any?
        results = true
        for i in 0..self.length-1
            if yield(self[i])
                results = true
            end
        end
        results
    end

    def my_none?
        results = true
        for i in 0..self.length-1
            if yield(self[i])
                results = false
            end
        end
        results
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
        for i in 0..self.length
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

my_proc = proc.new{|x| x**2}

[1,2,3,4,5].my_each {|x| p x}
[1,2,3,4,5].my_each_with_index {|value,index| p "#{index} with a value of #{value}"}
p [1,2,3,4,8].my_select {|item| item.odd?}
[1,2,6,4,5].my_all?{|element| p element.even?}
[1,2,3,4,5].my_any?{|item| p item.odd?}
[1,2,3,4,5].my_none?{|element| p element.even?}
p [1,2,3,4,5].my_count{|item| item < 5}
p [1,2,3,4,5].my_map{|x|  x }
p [1,2,3,4,5].my_map(my_proc)
[2,4,5].my_inject{|total,num1| p total*num1}

