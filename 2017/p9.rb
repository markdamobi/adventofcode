def read_stream(file)
  File.read(file)
end

def Stream
  attr_reader :stream
  def initialize(stream)
    @stream = stream
  end
end


def run
  # stream = Stream.new(read_stream('2017/p9_test.txt'))
  stream = Stream.new(read_stream('2017/p9_input.txt'))


end
