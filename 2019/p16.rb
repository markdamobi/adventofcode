#signal is string of digits.
def run1(signal:)
  fft = FFT.new(signal: signal)
  100.times { fft.phase }
  fft.display[0..7]
end

def run2(signal:)
  fft = FFT.new(signal: signal * 10000)
  100.times { fft.phase }
  offset = signal[0..7].to_i
  fft.display[offset..offset+7]
end


class FFT
  #signal is string of digits.
  def initialize(signal:)
    @signal = signal.split("").map(&:to_i)
    @base_pattern = [0, 1, 0, -1]
  end

  attr_reader :signal, :base_pattern

  def phase
    output = []
    (0...signal.size).each.with_index do |sig, i|
      pattern = repeat_pattern(i+1) #also creates a cycle of the pattern.
      output << tick(pattern)
    end
    @signal = output
    display
  end

  def tick(pattern)
    su = 0
    signal.each do |sig|
      su += sig * pattern.next
    end
    su.abs % 10
  end

  def display
    signal.join
  end

  def repeat_pattern(n)
    new_pattern = []
    base_pattern.each{ |pt| new_pattern += Array.new(n, pt) }
    new_pattern = new_pattern.cycle
    # new_pattern = base_pattern.map{ |pt| Array.new(n, pt) }.flatten.cycle
    new_pattern.next #skip first item.
    new_pattern
  end
end