# Several Ruby methods which implement Simple and Twisted tabulation
# https://dl.acm.org/doi/abs/10.1145/3068772

require 'benchmark'

$N = 600000
$TIMES = 100
$H = Array.new(8) { Array.new(256) { rand(18446744073709551615) } }
$H1 = Array.new(8) { Array.new(256) { rand(18446744073709551615) } }
$H2 = Array.new(16) { Array.new(16) { rand(18446744073709551615) } }
$H3 = Array.new(8) { Array.new(256) { rand(340282366920938463463374607431768211455) } }

class Ana; end
$objects = Array.new($N) { Ana.new() }

def benchmark_hash
  time = Benchmark.realtime do
    $TIMES.times do
      hash = {}
      $objects.each { |obj| hash[obj] = true }
    end
  end
  time.round(2)
end

puts "Current implementation: #{benchmark_hash}"

class Object
  def hash
     pieces = [object_id].pack('Q').unpack('CCCCCCCC')
     pieces.each_with_index.inject(0) { |xor, (x, i)| xor ^ $H[i][x] }
  end
end
puts "Simple tabulation 1: #{benchmark_hash}"

class Object
  def hash
    x = object_id
    h = 0
    8.times do |i|
      h ^= $H[i][x & 0xFF]
      x >>= 8
    end
    h
  end
end
puts "Simple tabulation 2: #{benchmark_hash}"

class Object
  def hash
    x = object_id
    h = 0
    16.times do |i|
      h ^= $H2[i][x & 0xF]
      x >>= 4
    end
    h
  end
end
puts "Simple tabulation 3: #{benchmark_hash}"

class Object
  def hash
    x = object_id
    h = 0
    7.times do |i|
      h ^= $H3[i][x & 0xFF]
      x >>= 8
    end
    h ^= $H3[7][(x ^ h) & 0xFF]
    h >> 64
  end
end
puts "Twisted tabulation: #{benchmark_hash}"

class Object
  def hash
    x = object_id
    h0 = 0
    8.times do |i|
      h0 ^= $H[i][x & 0xFF]
      x >>= 8
    end
    h1 = 0
    8.times do |i|
      h1 ^= $H1[i][h0 & 0xFF]
      h0 >>= 8
    end
    h1
  end
end
puts "Double tabulation: #{benchmark_hash}"

