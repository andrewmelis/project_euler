class Fibonacci
  include Enumerable

  def each
    f1, f2 = 0,1
    loop do
      yield f1  
      f1, f2 = f2, f1+f2
    end
  end
  
end
