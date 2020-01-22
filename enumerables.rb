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
end
[1,2,3,4,5].my_each {|x| p x}
[1,2,3,4,5].my_each_with_index {|value,index| p "#{index} with a value of #{value}"}
p [1,2,3,4,8].my_select {|item| item.odd?}
[1,2,6,4,5].my_all?{|element| p element.even?}
[1,2,3,4,5].my_any?{|item| p item.odd?}
[1,2,3,4,5].my_none?{|element| p element.even?}