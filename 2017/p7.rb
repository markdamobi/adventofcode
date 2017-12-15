
require 'active_support/all'
require 'byebug'
def read_tree(file)
  File.readlines(file).map{|l| l.strip.gsub(/[(),\-\>]/,"").split(/\s+/) }
end


class Tree
  attr_reader :relations, :base
  def initialize(relationships)
    set_relations(relationships)
    set_base
    set_tower_weights(base)
  end

  def set_relations(relationships)
    @relations = {}
    relationships.each do |details|
      key = details[0]
      weight = details[1].to_i
      kids = details[2..-1]
      @relations[key] = {weight: weight, kids: kids}
    end

    with_kids.each{|k,v| v[:kids].each{|kid| @relations[kid][:parent] = k; @relations[kid][:siblings]=v[:kids]-[kid]}}
  end

  def with_kids
    relations.deep_dup.keep_if{ |key, details| details[:kids].present? }
  end

  def with_no_kids
    relations.deep_dup.keep_if{ |key, details| details[:kids].blank? }
  end

  def set_base
    all_children = relations.map{|k,v| v[:kids]}.flatten.uniq
    @base = relations.keys.find{|k| !all_children.include? k}
  end

  def set_tower_weights(program)
    if relations[program][:tower_weight].present?
      return
    elsif relations[program][:kids].blank?
      @relations[program][:tower_weight] = relations[program][:weight]
      return
    else
      kids = relations[program][:kids]
      kids.each{|kid| set_tower_weights(kid)}
      @relations[program][:tower_weight] = relations[program][:weight] + kids.map{|kid| relations[kid][:tower_weight]}.sum
    end
  end

  def get_siblings_with_discrepancy
    parent =   relations[relations.find{|k,v| [v[:tower_weight]] != relations[k][:siblings].map{|s| relations[s][:tower_weight]}.uniq }[0]][:parent]
    relations[parent][:kids].map{|k| [k, relations[k][:tower_weight]]}
  end
end


def run1
  relationships = read_tree('2017/p7_input.txt')
  tree = Tree.new(relationships)
  tree.base
end

def run2
  relationships = read_tree('2017/p7_input.txt')
  tree = Tree.new(relationships)
  tree.get_siblings_with_discrepancy
  # [["jriph", 2102], ["bykobk", 2097], ["uylvg", 2097], ["yxhntq", 2097], ["ywdvft", 2097]]
  # this means we need to subtract 5 from the weight value of jriph.
end

def testrun
  relationships = read_tree('2017/p7_test.txt')
  tree = Tree.new(relationships)
  tree.base
end
