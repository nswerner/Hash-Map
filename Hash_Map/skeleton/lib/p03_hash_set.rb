class HashSet
  # attr_reader :count, :store
  attr_accessor :store, :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      self[key] << key
      self.count += 1
      resize! if store.length < count
      true
    end
  end

  def include?(key)
    self[key].include?(key) 
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      self.count -= 1
    end
  end

  private
  def [](num)
   store[num.hash % num_buckets] 
  end

  def num_buckets
    store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    
    store.each do |bucket|
      bucket.each do |element|
        new_store[element.hash % (num_buckets * 2)] << element
      end
    end

    self.store = new_store
  end
end
