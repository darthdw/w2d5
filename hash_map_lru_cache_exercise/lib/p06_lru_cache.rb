require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max = 4, prc = Proc.new { |x| x ** 2 })
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key) # getting old stuff, update
      update_node!(@map[key])
      @map[key] = @store.last
    else # getting new stuff, add and maybe eject
      @store.append(key, calc!(key))
      @map[key] = @store.last
      eject! if count > @max
    end
    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
  end

  def eject!
    key_to_eject = @store.first.key
    @store.first.remove
    @map.delete(key_to_eject)
  end
end
