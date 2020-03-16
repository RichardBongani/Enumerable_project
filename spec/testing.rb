require_relative "../bin/enumerables.rb"


  a = [1,2,3,4,5]
  b = [2,4,5]

p "==============================================="
  p [1, 2, 3, 4, 5].my_each { |x| x }
  p "**********************************************"
  p a.each {|n| n }
  p "//////////////////MY EACH////////////////////////////"
  p [1, 2, 3, 4, 5].my_each { |x| x } ==  a.each {|n| n }
  p "============================================="
    [1, 2, 3, 4, 5].my_each_with_index { |value, index| p "my ind is #{index} with a value of #{value}" }
  p "***********************************************"
    a.each_with_index {|val, ind| p  "my index is #{ind} with val of #{val}"}
  p "////////////////////EACH WITH INDEX////////////////////////////"
  p [1, 2, 3, 4, 5].my_each_with_index { |value, index|  "#{index} with a value of #{value}" } == a.each_with_index {|val, ind| "my index is #{ind} with val of #{val}"}
  p "================================================"
  p [1, 2, 3, 4, 5].my_select{|item| item.even?}
  p "************************************************"
  p a.select { |n| n.even?}
  p "//////////////////SELECT//////////////////////////////"
  p [1, 2, 3, 4, 5].my_select(&:even?) ==  a.select { |n| n.even?}
  p "================================================"
  p [1, 2, 6, 4, 5].my_all? { |element| element < 15 }
  p "*************************************************"
  p a.all? {|element| element < 15}
  p "///////////////////ALL//////////////////////////////"
  p [1, 2, 6, 4, 5].my_all? { |element| element < 15 } == a.all? {|element| element < 15}
  p "================================================="
  p [1, 2, 3, 4, 5].my_any?(&:negative?)
  p "*************************************************"
  p a.any?{ |item| item.negative?}
  p "////////////////ANY//////////////////////////////"
  p [1, 2, 3, 4, 5].my_any?(&:negative?) == a.any?{ |item| item.negative?}
  p "================================================="
  p [1, 2, 3, 4, 5].my_none? { |element| element > 100 }
  p "**************************************************"
  p a.none? {|element| element > 100}
  p "/////////////////////NONE/////////////////////////"
  p [1, 2, 3, 4, 5].my_none? { |element| element > 100 } == a.none? {|element| element > 100}
  p "=================================================="
  p [1, 2, 3, 4, 5].my_count { |item| (item % 2).zero? }
  p "**************************************************"
  p a.count {|item| (item%2).zero?}
  p "//////////////////////COUNT////////////////////////"
  p [1, 2, 3, 4, 5].my_count { |item| (item % 2).zero? } == a.count {|item| (item%2).zero?}
  p "==================================================="
  p [1, 2, 3, 4, 5].my_map { |number| number * number }
  p "***************************************************"
  p a.map {|num| num * num}
  p "//////////////////////MAP///////////////////////////"
  p [1, 2, 3, 4, 5].my_map { |number| number * number } == a.map {|num| num * num}
  p "===================================================="
  p p [2, 4, 5].my_inject { |total, num1| total * num1 }
  p "****************************************************"
  p b.inject {|tot, val| tot*val}
  p "//////////////////////////INJECT/////////////////////"
  p p [2, 4, 5].my_inject { |total, num1| total * num1 } == b.inject {|tot, val| tot*val}
