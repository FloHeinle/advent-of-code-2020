# usage:
# awk -f day6.awk <aoc inputfile>


BEGIN {
  T = "\t";
}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
   # additional blank line makes handling
   # for the last group easier
   REC[++RC] = "";

  totalYesAnswers = 0;
  totalcountGroupAgreements = 0;
  for( r = 1; r <= RC; r++ ) {
    rec= REC[r];
    if( match(rec,"^$") ) {
      countGroupAgreements = 0;
      totalYesAnswers += length(G);

      for( a in G ){
        if( G[a] == GROUPSIZE) {
          countGroupAgreements++;
        }
        delete G[a];
      };
      GROUPSIZE = 0;
      totalcountGroupAgreements += countGroupAgreements;
    }
    else {
      if( !match(rec,"^[a-z]+$") ) {
        print("validation problem in line " r "\n" T rec);
      }
      GROUPSIZE++;
      for( i = 1; i <= length(rec); i++) {
        a = substr(rec,i,1);
        G[a]++;
      }
    }
  }
  print( "part1 solution:" totalYesAnswers);
  print( "part2 solution:" totalcountGroupAgreements);
}
