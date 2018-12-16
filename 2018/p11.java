public class Aoc11 {
  public static void main(String[] args) {
    part2(7347, 300); //gets answer in 2 seconds.
  }
  
  public static int cell_power(int x, int y,int snum) {
    int rackid = x+10;
    int plevel = (((((rackid * y) + snum ) * rackid)/100)%10) - 5;
    return plevel;
  }
  
  public static int[] part2(int s_num, int grid_size) {
    int[] max = {0,0,0};
    int max_v = 0;
    for(int x=1; x<= grid_size; x++) {
      for(int y=1; y<= grid_size; y++) {
        int[] ans = get_max(x,y,grid_size,s_num);
        int l_max_v = ans[0];
        int l_max_sq = ans[1];
        if (l_max_v > max_v) {
          max_v = l_max_v;
          int max_sq = l_max_sq;
          max[0] = x;
          max[1] = y;
          max[2] = max_sq;
        }
      }
    }
    System.out.println(""+max[0] + "," + max[1] + "," + max[2]);
    return max;
  }
  
  public static int[] get_max(int x, int y, int grid_size, int s_num) {
    int limit = grid_size - Math.max(x, y) + 1;
    int max_v = cell_power(x,y,s_num);
    int max_sq = 1 ;
    int local_max = max_v; 
    for(int sq=2; sq<= limit; sq++) {
      for(int i=x; i<=(x+sq-2); i++) {
        local_max += cell_power(i,y+sq-1,s_num);
      }
      for(int j=y; j<=(y+sq-2); j++) {
        local_max += cell_power(x+sq-1,j,s_num);
      }
      local_max += cell_power(x+sq-1,y+sq-1,s_num);
      if(local_max > max_v) {
        max_v = local_max;
        max_sq = sq;
      }
    }
    int[] ans = {max_v, max_sq};
    return ans;
  }
}