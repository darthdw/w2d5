require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    unless include?(el)
      el = el.hash
      resize! if @count == num_buckets
      @store[el % num_buckets] << el
      @count += 1
    end
  end

  def remove(el)
    if include?(el)
      el = el.hash
      @store[el % num_buckets].delete(el)
      @count -= 1
    end
  end

  def include?(el)
    el = el.hash
    @store[el % num_buckets].include?(el)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    all_nums = @store.flatten
    @count = 0
    @store = Array.new(num_buckets * 2) {Array.new}
    all_nums.each do |num|
      insert(num)
    end
  end
end
