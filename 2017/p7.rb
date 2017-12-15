
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
  end

  def set_relations(relationships)
    @relations = {}
    relationships.each do |details|
      key = details[0]
      weight = details[1].to_i
      kids = details[2..-1]
      @relations[key] = {weight: weight, kids: kids}
    end
  end

  def set_base
    all_children = relations.map{|k,v| v[:kids]}.flatten.uniq
    @base = relations.keys.find{|k| !all_children.include? k}
  end

end


def run1
  relationships = read_tree('2017/p7_input.txt')
  tree = Tree.new(relationships)
  tree.base
end

def testrun
  relationships = read_tree('2017/p7_test.txt')
  tree = Tree.new(relationships)
  tree.base
end
