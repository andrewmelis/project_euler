require './multiples'

def sum(array)
  array.inject{|sum,x| sum + x}
end

puts sum(Multiples.union(Multiples.generate(3,1000),Multiples.generate(5,1000)))

