class Fibonacci

  def self.generate(limit)
    terms = [1,2]

    terms.each_with_index do |object, index|
      if index > 0 
	next_term = terms[index-1] + object
	if next_term < limit
	  terms << next_term
	end
      end
    end
  end

  def self.evens(limit)
    generate(limit).select do |term|
       term % 2 == 0
    end
  end

  def self.sum_evens(limit)
    evens(limit).inject(0,:+)
  end
end
