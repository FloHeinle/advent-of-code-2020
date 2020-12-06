# usage: awk -f day2.awk <aoc inputfile>
BEGIN {
  T = "\t";
  C = 0;
}
{
  pe = $0;
  p = $3;
  range = $1;
  ruleletter = $2;
  gsub(":","",ruleletter);
  if(check_part1()) {
    PART_1_SOLUTION++;
  }
  if(check_part2()) {
    PART_2_SOLUTION++;
  }
}
function check_part1() {
  r = 0;
  split(range,arr,"-");
  min = arr[1]; max = arr[2];
  c = 0;
  for( i = 1; i <= length(p);i++) {
    x = substr(p,i,1);
    if( x == ruleletter) {
      c++;
    }
  }
  r = ((c >= min) && (c <= max));
  return(r);
}
function check_part2() {
  r = 0;
  split(range,arr,"-");
  min = arr[1]; max = arr[2];
  c = 0;
  x1 = substr(p,min,1)
  x2 = substr(p,max,1)
  if( x1 == ruleletter) {
    c++;
  }
  if( (min != max) && (x2 == ruleletter)) {
    c++;
  }
  if(min == max) {
    print(pe);
  }
  r = (c == 1);
  return(r);
}
END {
  print(PART_1_SOLUTION);
  print(PART_2_SOLUTION);
}
