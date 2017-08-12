class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count || i < -@count
    return @store[i] if i >= 0
    return @store[@count + i] if i < 0
  end

  def []=(i, val)
    return nil if i >= @count || i < -@count
    if i >= 0
      @store[i] = val
    else
      @store[@count + i] = val
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < capacity
      return true if self[i] == val
      i += 1
    end
    false
  end

  def push(val)
    resize! if count == capacity
    @store[count] = val
    @count += 1
    val
  end

  def unshift(val)
    resize! if count == capacity
    i = @count
    while i > 0
      @store[i] = @store[i - 1]
      i -= 1
    end
    @count += 1
    @store[0] = val
  end

  def pop
    return nil if @count == 0
    popped = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    popped
  end

  def shift
    shifted = @store[0]
    i = 0
    while i < @count - 1
      @store[i] = @store[i + 1]
      i += 1
    end
    @count -= 1
    shifted
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    i = 0
    while i < @count
      yield(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    each_with_index do |el, i|
      return false if other[i] != el
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_arr = StaticArray.new(capacity * 2)
    i = 0
    while i < capacity
      new_arr[i] = @store[i]
      i += 1
    end
    @store = new_arr
  end
end
