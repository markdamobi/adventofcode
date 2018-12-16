require './helper'

class Graph 
  ## source is some item. could be string, int, even arr. 
  ## vertices is array of nodes. similar type to source. 
  ## edges is a hash where key is pair if directed vertices. value is weight. simple add permutation of pairs for undirected graph. 
  ## if edges is simply array if edges, assume weights of 1. 
  def initialize(source, vertices, edges, directed = false)
    # byebug
    if edges.is_a? Array
      @was_array = true
      @edges = edges.map{|e| [e,1]}.to_h
    elsif edges.is_a? Hash 
      @edges = edges
    end

    unless directed
      @edges.deep_dup.each do |k,v|
        @edges[[k[1], k[0]]] = v 
      end
    end


    @source = source 
    @vertices = vertices 
    init

    dijkstra
    
  end

  attr_reader :source, :vertices, :edges, :ss, :tt, :d

  def init 
    @d = {}
    @d[source] = 0 
    @ss = [source]
    @tt = vertices - [source] 
    vertices.each do |v|
      next if v == source 
      @d[v] = Float::INFINITY
    end

    ## initialize distances of source neighbors
    edges.each do |edge, val| 
      if edge[0] == source
        @d[edge[1]] = val
      end
    end

  end

  def dijkstra
    loop do 
      return if tt.empty?
      min_d = d.select{|vertex, val| vertex.in?(tt)}.values.min
      return if min_d == Float::INFINITY
      min_v = tt.find{|v| d[v] == min_d}
      relax_vertex(min_v)
    end


  end

  def relax_vertex(v)
    @ss << v 
    @tt.delete v

    edges.each do |edge, val| 
      next if (edge[0] != v) || edge[1].in?(ss)
      if d[v] + val < d[edge[1]]
        d[edge[1]] = d[v] + val 
      end
    end

  end

end