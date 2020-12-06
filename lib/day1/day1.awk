# usage: awk -f day1.awk <aoc inputfile>
BEGIN {
  T = "\t";
}
{
  M[$1] = 1;
}
END {
  for( k in M ) {
    m = 2020 - k;
    if( (m in M) ) {
      p = m*k;
      if( !(p in P2) ) {
        P2[p] = p;
        PART_1_SOLUTION = p;
      }
    }
    for( l in M ) {
      m = 2020 - k - l;
      if( (m in M) ) {
        p = m*k*l;
        if( !(p in P3) ) {
          P3[p] = p;
          PART_2_SOLUTION = p;
        }
      }
    }
  }
  print(PART_1_SOLUTION);
  print(PART_2_SOLUTION);
}
