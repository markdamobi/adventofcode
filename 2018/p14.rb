require './helper'

class Recipe
  def initialize
    @pos1, @prev1 = 0, 0
    @pos2, @prev2 = 1, 1
    # @r_scores = [3,7]
    @r_scores = "37"
    @num_ticks = 0
  end

  attr_reader :pos1, :pos2, :r_scores, :r_scoresstr,:prev1, :prev2, :num_ticks

  def tick
    new_recipe = (r_scores[pos1].to_i + r_scores[pos2].to_i).to_s
    @r_scores += new_recipe
    @prev1, @prev2 = pos1, pos2
    @pos1, @pos2 = (pos1 + 1 + r_scores[pos1].to_i)%r_scores.size, (pos2 + 1 + r_scores[pos2].to_i)%r_scores.size
    @num_ticks += 1
    r_scores
  end

  def predict10(n)
    n.times{ tick }
    10.times{ tick }
    score = r_scores[n...n+10]
    puts score 
    score
  end

  def part2(num)
    str = num.to_s
    num_rec_pre = 0
    len = str.size
    loop do 
      tick  
      if r_scores[-len..-1] == str
        num_rec_pre = r_scores.size - len
        break
      elsif r_scores[-len-1..-2] == str
        num_rec_pre = r_scores.size - len -1
        break
      end
    end

    puts num_rec_pre
    num_rec_pre
  end

end


### these approaches are pretty straight forward. doesn't work for part 2 though. Need to figure out the pattern. input 765071.