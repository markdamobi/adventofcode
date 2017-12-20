require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip.gsub('p=<','').gsub('v=<','').gsub('a=<','')[0..-2].split(/>, /) }
end

#### TODO: Revisit part 2. 
class Particle
  attr_reader :particles

  def initialize(particles)
    @particles = {}
    particles.each_with_index do |val, i|
      @particles[i] = {
        position: val[0].split(/,/).map(&:to_i),
        velocity: val[1].split(/,/).map(&:to_i),
        acceleration: val[2].split(/,/).map(&:to_i),
      }
    end
  end

  def tick
    @particles.each do |particle,details|
      @particles[particle][:velocity] = details[:velocity].zip(details[:acceleration]).map{|x| x.reduce(:+)}
      @particles[particle][:position] = details[:position].zip(@particles[particle][:velocity]).map{|x| x.reduce(:+)}
      check_for_collision(particle)
    end
  end

  def check_for_collision(particle)
    # collision_groups = particles.group_by{|i, details| details[:position].reduce(0){|acc,x| acc+x.abs}}
    #
    # # collision_groups.delete_if{|x| x.second.count == 1}
    # collision_groups.each{|i,dets| collision_groups.delete(i) if dets.count ==1 }
    #
    # part_ids = []
    # collision_groups.each do |dist, parts|
    #   parts.each{|part| @particles.delete(part[0])}
    # end

    deleted = false
    particles.each do |id, details|
      if (id != particle) &&  (details[:position] == particles[particle][:position])
        @particles.delete(id)
        deleted = true
      end
    end
    @particles.delete(particle) if deleted
  end
end

## this solution for part1 is pretty naive. TODO: rethink this to make it better.
def run1
  # s = SomeStuff.new(read_file('2017/p20_test.txt'))
  part = Particle.new(read_file('2017/p20_input.txt'))

  500.times{part.tick}

  #for part1
  # 500.times{part.tick}
  # min_dist = part.particles.values.map{|v| v[:position].reduce(0){|acc,x| acc+x.abs}}.min
  # p part.particles.find{|particle, details| details[:position].reduce(0){|acc,x| acc+x.abs} == min_dist}

  part.particles.count
end
