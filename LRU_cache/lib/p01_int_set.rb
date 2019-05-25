class MaxIntSet
  attr_reader :store
  def initialize(max)

    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @max
    
    @store[num] = true

  
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    if @store[num] == true
      true
    else
      false
    end
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num] = [num]
  end

  def remove(num)
    @store.delete_at(num)
  end

  def include?(num)
    if @store[num].empty? 
      return false
    else
      return true
    end
   
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    self.count += 1
    resize! if self.count > num_buckets
    
    num
  end

  def remove(num)
    self.count -= 1 if self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num % num_buckets]
  end

  def num_buckets
    self.store.length
  end

  def resize!
    old = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) {Array.new}
    old.flatten.each { |num| insert(num) }

  end
end
