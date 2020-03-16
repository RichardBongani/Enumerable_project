require_relative "../bin/enumerables.rb"

describe Enumerable do
  include Enumerable
  it "returns an object if no block is given" do
    expect([1, 2, 3, 4, 5].my_each { |x| x }).to be_an(Object)
  end

  it "returns a value in an array with its index" do
    expect([1, 2, 3, 4, 5].my_each_with_index { |value, index|"my ind is #{index} with a value of #{value}" }).to be_a(Enumerator)
  end

  it "returns an array with elements satisfying the passed condition" do
    expect([1, 7, 3, 4, 18].my_select{|item| item.even?}).to eql([4,18])
  end

  it "returns true if all the elements satisfy all the conditions",positive:true do
    expect([1, 2, 6, 4, 5].my_all? { |element| element < 15 }).to be(true)
  end

  it "returns false if all the elements satisfy all the conditions",negative:true do
    expect([1, 2, 6, 17, 5].my_all? { |element| element < 15 }).to be(false)
  end

  it "returns true if any element in the array satisfies the conditon", positive:true do
    expect([1, 2, 3, -4, 5].my_any?(&:negative?)).to be(true)
  end

  it "returns false if any element in the array satisfies the conditon", negative:true do
    expect([1, 2, 3, 4, 5].my_any?(&:negative?)).to be(false)
  end

  it "returns true if none of the elements in the array satisfy the condition", positive:true do
    expect([1, 2, 3, 4, 5].my_none? { |element| element > 100 }).to eq(true)
  end

  it "returns false if none of the elements in the array satisfy the condition", negative:true do
    expect([112, 200, 300, 444, 522].my_none? { |element| element > 100 }).to eq(false)
  end

  it "returns an integer that satisfies the condition of the block" do
    expect([1, 2, 3, 4, 5].my_count { |item| (item % 2).zero? }).to eq(2)
  end

  it "will check all elements of the array and make the passed changes" do
    expect([1, 2, 3, 4, 5].my_map { |number| number * number }).to eq([1, 4, 9, 16, 25])
  end

  it "will run through the array and will return a single integer" do
    expect([2, 4, 5].my_inject { |total, num1| total * num1 }).to eq(40)
  end
end
