require 'set'

class Graph

  ## edges is an array of arrays. array element can be 2 or 3 items. 2 items indicates unweighted(ie weight 1). 3 items indicates weight is 3rd item.
  ## directed is boolean. true or false. true by default. if not directed, edges will be resolved appropriately.
  ## vertices is simply an array of vertices. If vertices is not specified, code will infer vertices from edge list.

  def initialize(edges:, directed: true, vertices: nil)
    @directed = directed
    init_edges(edges.uniq)
    init_adjacency
    init_nodes(vertices: vertices)
  end

  ## counter, levels, and state are just specific to dfs.
  attr_reader :directed, :weights, :adjacency, :nodes, :counter, :levels, :state

  ## use given list of edges to setup hash of weights. key of weights is edges.
  def init_edges(edges)
    @weights = {}
    edges.each do |a, b, c|
      w = c.nil? ? 1 : c
      @weights[[a, b]] = w
      @weights[[b, a]] = w unless directed
    end
  end

  def get_edges
    weights.keys
  end

  def init_adjacency
    @adjacency = Hash.new { |h, k| h[k] = [] }
    get_edges.each{ |a, b| adjacency[a] << b }
    adjacency
  end

  def init_nodes(vertices:)
    if vertices.nil?
      @nodes = Set.new(get_edges.flatten)
    else
      @nodes = Set.new(vertices)
    end
  end

  def dijkstra(source:, destination: nil)
    processed = Set.new
    distances = {}
    nodes.each{ |n| distances[n] = Float::INFINITY }
    distances[source] = 0

    while(processed.size < nodes.size) ##keep going until we've visited all nodes.
      min_node = get_min_node(processed, distances)
      processed << min_node

      ## no need to keep processing if we found shortest distance to destination or remaining unproccessed nodes are unreachable.
      return distances if (min_node == destination) || (distances[min_node] == Float::INFINITY)

      unprocessed_neighbors = adjacency[min_node].select{ |neighbor| !processed.include?(neighbor) }

      unprocessed_neighbors.each do |nb|
        if(distances[nb] > (distances[min_node] + weights[[min_node, nb]]))
          distances[nb] = distances[min_node] + weights[[min_node, nb]]
        end
      end
    end
    distances
  end

  def get_min_node(processed, distances)
    unprocessed_nodes = nodes.select{ |n| !processed.include?(n) }
    unprocessed_nodes.min_by{|n| distances[n]}
  end

  ## helper for dfs
  def dfs_reset
    @counter = 0
    @state = {}
    @levels = {}
  end

  ## just does a dfs and returns the levels of items given a particular source.
  ## untested.
  def dfs(source:)
    dfs_reset
    dfs_helper(source: source)
    levels
  end

  def dfs_helper(source:)
    state[source] = :discovered
    @counter += 1
    level[source] = counter

    adjacency[source].each do |neighbor|
      if(state[source] != :discovered)
        dfs_helper(source: neighbor)
      end
    end
    @counter -= 1
  end
end