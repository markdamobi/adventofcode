require 'set'
require 'benchmark'
require 'byebug'
require 'active_support/all'

# Benchmark.bm{|bm| bm.report { put_code_here } }

def freq(arr)
  h = Hash.new(0)
  arr.each do |c|
    h[c] += 1
  end
  h
end