class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    string = self.stringify_array
    codified_string = string.chars.map(&:ord)
    large_num = codified_string.inject { |accum, el| accum.to_s + el.to_s }.to_i
    binary = large_num.to_s(2)
    flatten_binary(binary)
  end
  

  def stringify_array
    string = "["
    self.each do |element|
      if element.is_a?(Array)
        string += element.stringify_array
      else
        string += element.to_s
      end
    end

    string += "]"
  end

  def flatten_binary(string)
    segment = string[0..13].to_i
    rest = string[14..-1]

    until rest.nil? || rest.empty?
      new_segment = rest[0..13].to_i
      segment += new_segment
      rest = rest[14..-1]
    end
  
    segment
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end


#   load  "lib/p02_hashing.rb"