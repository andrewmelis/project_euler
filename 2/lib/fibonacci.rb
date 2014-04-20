class Fibonacci
  include Enumerable

  def self.each
    return enum_for(:each) unless block_given? #why need block given?

    #init
    f1, f2 = 0,1
    loop do
    #while f1 <= limit do 
      #return
      yield f1
      #advance
      f1, f2 = f2, f1+f2
    end
  end
  

  #def each
  #  return enum_for(:each) unless block_given?

  #  fib = Enumerator.new do |y|
  #    a = b = 1
  #    loop {
  #      #puts a
  #      y.yield(a)
  #      a, b = b, a+b
  #    }
  #  end
  #end

end
