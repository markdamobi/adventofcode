require 'byebug'

def run1(file: 'p12.txt')
  m1 = Moon.new(x:17, y:5, z:1)
  m2 = Moon.new(x:-2, y:-8, z:8)
  m3 = Moon.new(x:7, y:-6, z:14)
  m4 = Moon.new(x:1, y:-10, z:4)
  jp = Jupiter.new(moons:[m1, m2, m3, m4])
  jp.move(1000)
  jp.total_energy
end

def run2(file: 'p12.txt')

  #test
  # m1 = Moon.new(x:-8, y:-10, z:0)
  # m2 = Moon.new(x:5, y:5, z:10)
  # m3 = Moon.new(x:2, y:-7, z:3)
  # m4 = Moon.new(x:9, y:-8, z:-3)


  m1 = Moon.new(x:17, y:5, z:1)
  m2 = Moon.new(x:-2, y:-8, z:8)
  m3 = Moon.new(x:7, y:-6, z:14)
  m4 = Moon.new(x:1, y:-10, z:4)
  jp = Jupiter.new(moons:[m1, m2, m3, m4])

  jp.r2
end

class Jupiter
  def initialize(moons:)
    @moons = moons
    @time = 0
    @sx = { gx => 0 }
    @sy = { gy => 0 }
    @sz = { gz => 0 }
    @fx = false
    @fy = false
    @fz = false
  end

  attr_reader :time, :moons, :sx, :sy, :sz, :fx, :fy, :fz

  def move(num_steps)
    num_steps.times{ tick }
  end

  def r2
    a, b, c = animate
    a.lcm(b).lcm(c)
  end

  def animate
    while true
      tick
      break if (fx && fy&& fz)
    end
    [fx, fy, fz]
  end


  def total_energy
    moons.sum(&:total_energy)
  end

  def tick
    apply_gravity
    update_positions
    @time += 1
    @fx = (time + 1) if sx[g(:x)] && !fx
    @fy = (time + 1) if sy[g(:y)] && !fy
    @fz = (time + 1) if sz[g(:z)] && !fz
  end

  def g(sym)
    moons.map(&sym).join("-*-")
  end

  def apply_gravity
    moons.combination(2).each do |m1, m2|
      m1.g_effect(m2)
    end
  end

  def update_positions
    moons.each{ |m| m.move }
  end
end

class Moon
  def initialize(x:, y:, z:)
    @x = x
    @y = y
    @z = z
    @vx = 0
    @vy = 0
    @vz = 0
  end

  attr_reader :x, :y, :z
  attr_accessor :vx, :vy, :vz

  def g_effect(m2)
    @vx += (m2.x <=> x)
    @vy += (m2.y <=> y)
    @vz += (m2.z <=> z)

    m2.vx += -(m2.x <=> x)
    m2.vy += -(m2.y <=> y)
    m2.vz += -(m2.z <=> z)
  end

  def move
    @x += vx
    @y += vy
    @z += vz
  end

  def potential_energy
    x.abs + y.abs + z.abs
  end

  def kinetic_energy
    vx.abs + vy.abs + vz.abs
  end

  def total_energy
    potential_energy * kinetic_energy
  end

  def to_s
    "pos=<x= #{x}, y= #{y}, z=#{z}>, vel=<x= #{vx}, y= #{vy}, z=#{vz}>"
  end
end

## this code can be made better...