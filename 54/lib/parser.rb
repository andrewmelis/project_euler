class Parser
  attr_reader :parsed_file

  def initialize(filename)
    @parsed_file = read_and_split(filename)
  end
  
  def read_and_split(filename)
   filename.readlines.split(" ")
  end

  def games

  end

end
