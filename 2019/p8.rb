def run1(file: 'p8.txt')
  data = File.read(file).chomp
  min_l = d(data)
  min_l.count("1") * min_l.count("2")
end

def d(data)
  data.chars.each_slice(150).min_by{|s| s.count("0")}
end

def run2(file: 'p8.txt', x:6, y:25)
  data = File.read(file).chomp
  img = []
  data.chars.each_slice(x*y){|s| img << s}
  image = Img.new(data: img, x:x, y:y)
  image.decode
  image.show
end



class Img
  def initialize(data:, x:, y:)
    @x = x
    @y = y
    @data = data
    make_layers
  end

  attr_reader :data, :layers, :final_layer, :x, :y

  def make_layers
    @layers = []
    data.each do |line|
      @layers << get_layer(line)
    end
  end

  def get_layer(line)
    layer = []
    line.each_slice(y){ |row| layer << row }
    layer
  end

  ##TODO: figure out a better way to do this...
  def decode
    @final_layer = []
    layers[0].each{ |row| @final_layer << row.dup }

    (0..x-1).each do |i|
      (0..y-1).each do |j|
        val = "2"
        layers.each do |layer|
          if(layer[i][j] == "0")
            val = "0"
            break
          elsif(layer[i][j] == "1")
            val = "1"
            break
          end
        end
        @final_layer[i][j] = val
      end
    end

  end

  def show
    puts final_layer.map{|l| l.join}.join("\n")
  end
end


