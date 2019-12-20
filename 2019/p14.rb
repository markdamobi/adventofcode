require_relative './graph'

def run1(file: "p14.txt", num_fuels: 1)
  reactor = Reactor.new(file: file, num_fuels: num_fuels)
  reactor.set_levels
  reactor.get_num_ores
end

# for part 2, Just do a sort of binary search until you get something like this.
# I just played around with this manually in console. Probably should write some code to do the manual search for me
#   by giving it some upper bound and lower bound.
# >> run2(num_fuels: 6226152)
# => 999999986236
# >> run2(num_fuels: 6226153)
# => 1000000152093

class Reactor
  def initialize(file:, num_fuels: 1)
    @reactions = {}
    parse_file(file)
    make_graph
    @rr = [Element.new(name: "FUEL", quantity: num_fuels)] ##this is just a list of the things that need to be expanded at a certain instance. initialize with 1 fuel.
    @excess_ore = 0
  end

  attr_reader :reactions, :graph, :levels, :rr, :excess_ore

  def make_graph
    edges = []
    reactions.each do |output, details|
      details[:components].each do |comp, comp_q|
        edges << [comp, output]
      end
    end
    @graph = Graph.new(edges: edges)
  end

  def set_levels
    @levels = @graph.get_bfs_levels(source: "ORE")
  end

  def set_levels
    qq = ["ORE"]
    @levels = {}
    parents = {}
    while !qq.empty? do
      u = qq.shift #dequeue
      @levels[u] = (levels[parents[u]] || -1) + 1
      graph.adjacency[u].each do |v|
        parents[v] = u
        qq << v
      end
    end
    levels
  end

  def parse_file(file)
    lines = File.readlines(file).map{ |l| l.strip.chomp }
    lines.each do |line|
      parse_line(line)
    end
  end

  ## takes a line of the form 1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP and adds
  ## "XMNCP" => {quantity: 2, components: {"MZWV" => 1, ..., etc}}
  def parse_line(line)
    components, item = line.split(" => ")
    i_quantity, i = item.split
    comps = {}
    components = components.split(", ")
    components.each do |component|
      quantity, comp = component.split
      comps[comp] = quantity.to_i
    end
    @reactions[i] = { quantity: i_quantity.to_i, components: comps }
  end

  def get_num_ores
    level = levels.values.max

    ## start at items farthest away from ore. expand until we get to ore.
    while(level > 0)
      items_at_level = levels.keys.select{ |k| levels[k] == level } ## get items at current level.

      items_to_expand = rr.select{ |el| items_at_level.include?(el.name) }

      items_to_expand.each do |item|
        expand(item, level: level) ##replace with parents
      end
      compress_unify #chunk items together
      level -= 1
    end
    rr[0].quantity
  end


  ## this process isn't complete yet. I need to put into account what is happening with the quantity.
  ## no partial reaction but excess is okay.
  def expand(item, level: nil)
    if !item.is_a?(Element)
      item = rr.find{ |x| x.name == item }
    end

    @rr.delete(item)

    multiplier = (Float(item.quantity) / reactions[item.name][:quantity]).ceil
    reactions[item.name][:components].each do |comp, quantity|
      @rr << Element.new(name: comp, quantity: quantity * multiplier)
    end
    rr
  end

  def compress_unify
    gp = rr.group_by(&:name)
    @rr = []
    gp.each do |name, items|
      new_element = Element.new(name: name)
      items.each{ |item| new_element.add(item) }
      @rr << new_element
    end
    rr
  end

  def state
    rr.each { |item| puts item }
    nil
  end
end

class Element
  def initialize(quantity: 0, name:)
    @quantity = quantity
    @name = name
  end

  attr_reader :name, :quantity

  def add(other)
    return if name != other.name
    @quantity += other.quantity
  end

  def to_s
    "#{name}: #{quantity}"
  end
end