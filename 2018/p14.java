
public class Aoc14 {
  int pos1 = 0; 
  int pos2 = 1; 
  String r_scores = "37";
  
  public static void main(String[] args) {
    
  }
  
  
  public String predict10(int n) {
    for(int i = 1; i<= n + 10; i++) {
      tick();
      
    }
    String score = r_scores.substring(n, n+10);
    System.out.println(score);
    return score;
  }
  
  public void tick() {
    String new_recipe = "" + (Character.getNumericValue(r_scores.charAt(pos1)) + Character.getNumericValue(r_scores.charAt(pos2)));
    r_scores += new_recipe;
    pos1 = (pos1 + 1 + Character.getNumericValue(r_scores.charAt(pos1)))%r_scores.length() ;
    pos2 = (pos2 + 1 + Character.getNumericValue(r_scores.charAt(pos2)))%r_scores.length() ;
  }
  

  // This doesn't work. It probably requires a few years to get the answer with input 765071. 
  // I'm sure there's some pattern somwhere that prevents unnecessary computation, I just have to figure thaat out. 
  public int part2(int num) {
    String str = "" + num;
    int num_rec_pre = 0;
      int len = str.length();
      while(true) {
        tick();
        int l = r_scores.length();
        if(r_scores.substring(Math.floorMod((l-len), l),l).equals(str)) {
          num_rec_pre = r_scores.length() - len;
          break;
        }
        else if(r_scores.substring(Math.floorMod((l-len-1),l),l-1).equals(str)) {
          num_rec_pre = r_scores.length() - len -1;
          break;
        }
      }
      System.out.println(num_rec_pre);
      return num_rec_pre;
  }
  
}
