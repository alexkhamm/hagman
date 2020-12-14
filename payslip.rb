def fib(number)
    array = [1,1]
    i = 2
    x = 0
    while i < number do
      x = array[i-1] + array[i-2]
      array.push(x)
      i += 1
    end
    p array  
end
  
  fib(6)