class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    map.with_index {|el, i| el.hash * 103067 + i * 103069}.reduce(:*).hash
  end
end

class String
  def hash
    ords = chars.map { |ch| ch.ord }
    (ords.map(&:to_s).join.to_i * 102953 * 103079).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a.sort
    arr = arr.hash * 103049 * 103007
    arr.hash
  end
end
