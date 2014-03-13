class Multiples
  def self.generate(start,limit)
    a = []
    counter = start
    while counter <= limit do 
      a << counter if counter % start == 0
      counter += start
    end
    a
  end

  def self.union(list1,list2)
    list1 | list2
  end

end


