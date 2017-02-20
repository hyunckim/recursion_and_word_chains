def range_recursive(start, final)
  return [final] if start == final  # base case
  [start] + range_recursive(start + 1, final)
end


def sum_of_array_recursive(array)
  return array.first if array.length == 1
  array.first + sum_of_array_recursive(array[1..-1])
end


def sum_of_array_iterative(array)
  #array.reduce(:+)
  sum = 0
  array.each { |el| sum += el }
  sum
end


def exponent_one(base, power)
  return 1 if power == 0
  base * exponent_one(base, power - 1)
end


def exponent_two(base, power)
  return 1 if power == 0
  return base if power == 1

  if power.odd?
    recursive_return = exponent_two(base, (power - 1) / 2)
    return base * (recursive_return * recursive_return)

  else
    recursive_even = exponent_two(base, power / 2)
    return recursive_even * recursive_even
  end

end

# 1,1,2,3,5,8,13,21,34,55

def fib_r(n)
  return [1] if n == 1
  return [1,1] if n == 2

  previous = fib_r(n - 1)
  previous + [previous[-1] + previous[-2]]

end

def fib_i(n)
  return [1] if n == 1
  array = [1,1]
  until array.length == n
    array << array[-1] + array[-2]
  end

  array
end

class Array
  def deep_dup
    self.map do |el|
      el.is_a?(Array) ? el.deep_dup : el
    end
  end
end

def subsets(array)
  return [[]] if array.empty?

  old_subsets = subsets(array[0...-1])
  old_subsets.concat(old_subsets.map {|el| el + [array[-1]]})
end





# def subsets(array)
#   return [[]] if array.empty?
#   old_subsets = subsets(array[0...-1])
#   new_subsets = old_subsets.map {|el| el + [array[-1]]}
#   old_subsets.concat(new_subsets)
# end




# length 0 => [[]]
# length 1 => [[1]]
#length 2 => [[1,2],[2,1]]

def permutations(array)
  return [[]] if array.empty?
  return [array] if array.length == 1

  return [array].concat([array.reverse]) if array.length == 2

  step = permutations(array[0...-1])

  holder = Array.new(step.length * array.length)

  step.map.with_index do |pair, jdx|
    temp = pair + [array[-1]]
    array.length.times do |idx|
      idx.times { holder << (temp).unshift(temp.pop)}
    end
  end

end

def bsearch(array, target)
  return nim if array.length == 1 && array.first != target
  array = array.sort!

  median = array.length / 2
  if array[median] == target
    return median

  elsif target > array[median]
    subanswer = bsearch(array[(median + 1) .. -1], target)
    if subanswer.nil?
      return nil
    else
      median + 1 + subanswer
    end

  else
    return bsearch(array[0 .. (median - 1)], target)
  end
end



def bsearch(array, target)
  return nil if array.length == 1 && array.first != target
  array = array.sort!

  median = array.length/2
  if array[median] == target
    return median

  elsif target > array[median]
    sub_answer = bsearch(array[ (median + 1) .. -1], target)
    if sub_answer.nil?
      return nil
    end
    return sub_answer + median + 1
  else
    return sub_answer = bsearch(array[ 0 .. (median -1) ], target)
  end
end


def merge_sort(array)
   return array if array.length == 1
   median = array.length / 2
   a = array[0...median]
   b = array[median..-1]
   merge_helper(merge_sort(a), merge_sort(b))
end

def merge_helper(first_arr, second_arr )
    return first_arr if second_arr.empty?
    return second_arr if first_arr.empty?
  if first_arr.first > second_arr.first
    [second_arr.first] + merge_helper(first_arr,second_arr[1..-1])
  else
    [first_arr.first] + merge_helper(first_arr[1..-1],second_arr)
  end
end

def make_change(amount, coin_values = [25,10,5,1])
  biggest_coin = coin_values.select {|coin| amount / coin > 0}.max
  remainder = amount - biggest_coin
  return [biggest_coin] if remainder == 0
  [biggest_coin] + make_change(remainder)
end
