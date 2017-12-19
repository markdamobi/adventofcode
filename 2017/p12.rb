require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip.gsub(" ", "").split(/<->|,/).map(&:to_i)}
end

class Plumber
  attr_reader :relations, :partitions, :original_relations

  def initialize(relations)
    @relations = relations
    @original_relations = relations.dup
    @partitions = []
  end

  def partition
    pointer = 0
    while relations.present?
      part = relations.first
      @relations.shift
      pointer = 0
      while pointer < relations.length
        relation = relations[pointer]
        if (part & relation).present?
          part = (part + relation).uniq
          @relations.delete_at(pointer)
          pointer = 0
        else
          pointer += 1
        end
      end
      @partitions << part
    end
    partitions
  end


end


def run1
  # plum = Plumber.new(read_file('2017/p12_test.txt'))
  plum = Plumber.new(read_file('2017/p12_input.txt'))
  plum.partition
  plum.partitions.find{|part| part.include? 0}.count

end
