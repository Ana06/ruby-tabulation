# Ruby script to test Ruby Hashing performance of the code in:
# https://github.com/Ana06/ruby/tree/tabulation

require 'benchmark'

$N = 600000
$TIMES = 100

class Ana; end
$objects = Array.new($N) { Ana.new() }

# Do not benchmark the filling of the random matrix
hash = {}
hash[Ana.new()] = true

def benchmark_hash
  time = Benchmark.realtime do
    $TIMES.times do
      hash = {}
      $objects.each { |obj| hash[obj] = true }
    end
  end
  time.round(2)
end

puts "Time to add #{$N} objects to an empty hash #{$TIMES} times: #{benchmark_hash}"

