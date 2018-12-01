require 'set'
require 'benchmark'
require 'byebug'

def bench(some_result)
  Benchmark.bm{|bm| bm.report { puts "\nanswer: #{some_result}\n" } }
end