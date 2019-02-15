class MaxIntSet
  attr_reader :max, :store
  
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end
  
  def insert(num)
    self.store[num] = true if is_valid?(num)
  end
  
  def remove(num)
    self.store[num] = false if is_valid?(num)
  end
  
  def include?(num)
    self.store[num] if is_valid?(num)
  end
  
  private
  
  def is_valid?(num)
   raise "Out of bounds" unless num.between?(0, max)
   true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end
  
  def insert(num)
    store[num % num_buckets] << num unless include?(num)
  end
  
  def remove(num)
    store[num % num_buckets].delete(num)
  end
  
  def include?(num)
    store[num % num_buckets].any? { |el| el == num }
  end
  
  private

  attr_reader :store
  
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store
  
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(num)
    unless include?(num)
      self.count += 1
      self[num] << num
      resize! if store.length < count
    end
  end
  
  def remove(num)
    if include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end
  
  def include?(num)
    self[num].include?(num)
  end
  
  private
  attr_writer :store, :count
  
  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    
    store.each do |bucket|
      bucket.each do |element|
        new_store[element % (num_buckets * 2)] << element
      end
    end

    self.store = new_store
  end

end
