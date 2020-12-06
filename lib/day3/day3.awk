# usage: gawk -f day3.awk <aoc inputfile>
BEGIN {
  T = "\t";
  RIGHT[++slopes] = 1;DOWN[slopes] = 1;
  RIGHT[++slopes] = 3;DOWN[slopes] = 1;
  RIGHT[++slopes] = 5;DOWN[slopes] = 1;
  RIGHT[++slopes] = 7;DOWN[slopes] = 1;
  RIGHT[++slopes] = 1;DOWN[slopes] = 2;
}
{
  row = $0;
  R[++numrows] = row;
}
END {
  p = 1;
  for( s = 1; s<= slopes;s++) {
    solution = calculate(RIGHT[s],DOWN[s]);
    if( s == 2 ) {
      PART_1_SOLUTION = solution;
    }
    p = p * solution;
  }
  PART_2_SOLUTION = p;
  print(PART_1_SOLUTION);
  print(PART_2_SOLUTION);

}
function calculate(right,down) {
  start = 0;
  C = 0;
  idxnextrow = 1;
  for( i = 1; i < numrows; i++) {
    idxnextrow = idxnextrow + down;
    if( idxnextrow <= numrows ) {
      nextrow = R[idxnextrow];
      start += right;
      idx = start % length(nextrow);
      f = substr(nextrow,idx+1,1);
      #print( idxnextrow T start T f T idx);
      if( f == "#") {
        C++;
      }
    }
  }
  return(C);
}
