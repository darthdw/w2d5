class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    next_node = @next
    prev_node = @prev
    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head_dummy = Node.new
    @tail_dummy = Node.new
    @head_dummy.next = @tail_dummy
    @tail_dummy.prev = @head_dummy
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head_dummy.next
  end

  def last
    @tail_dummy.prev
  end

  def empty?
    @head_dummy.next == @tail_dummy
    @tail_dummy.prev == @head_dummy
  end

  def get(key)
    node_result = node_search(key)
    return nil if node_result.nil?
    node_result.val
  end

  def include?(key)
    !!node_search(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last_node = @tail_dummy.prev

    last_node.next = new_node
    new_node.next = @tail_dummy
    new_node.prev = last_node
    @tail_dummy.prev = new_node
  end

  def update(key, val) # find by key, update val
    node_result = node_search(key)
    return nil if node_result.nil?
    node_result.val = val
  end

  def remove(key)
    current_node = node_search(key)
    return nil if current_node.nil?

    prev_node = current_node.prev
    next_node = current_node.next
    prev_node.next = next_node
    next_node.prev = prev_node

    current_node
  end

  def node_search(key)
    current_node = @head_dummy.next
    until current_node.key == key
      return nil if current_node.next == nil
      current_node = current_node.next
    end
    current_node
  end

  def each
    # until @tail_dummy == current_node
    # keep going
    current_node = @head_dummy.next
    until current_node == @tail_dummy
      yield(current_node)
      current_node = current_node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
