require 'active_support/all'
require 'byebug'
def read_file(file)
  File.readlines(file).map{|l| l.strip.gsub('p=<','').gsub('v=<','').gsub('a=<','')[0..-2].split(/>, /) }
end

class Particle
  attr_reader :particles, :min_dist

  def initialize(particles)
    @particles = {}
    @min_dist = 999999999999
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
      # byebug
      @particles[particle][:velocity] = details[:velocity].zip(details[:acceleration]).map{|x| x.reduce(:+)}
      @particles[particle][:position] = details[:position].zip(@particles[particle][:velocity]).map{|x| x.reduce(:+)}
      # byebug
      # @min_dist = [min_dist, @particles[particle][:position].reduce(:+).abs].min unless [min_dist, @particles[particle][:position].reduce(:+).abs].min == 0
    end
  end
end


def run1
  # s = SomeStuff.new(read_file('2017/p20_test.txt'))
  part = Particle.new(read_file('2017/p20_input.txt'))
  1000.times{part.tick}
  # byebug
  min_dist = part.particles.values.map{|v| v[:position].reduce(0){|acc,x| acc+x.abs}}.min
  part.particles.find{|particle, details| details[:position].reduce(0){|acc,x| acc+x.abs} == min_dist}
end
