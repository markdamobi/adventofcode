  def rotate_array(arr)
    new_arr = []
    (0...arr[0].length).each do |i|
      new_arr << (0...arr.length).map{|j| arr[arr.length - 1 - j][i]}
    end
    new_arr
  end

  ## flips left to right.
  def flip(arr)
    arr.map{|part| part.reverse}
  end
