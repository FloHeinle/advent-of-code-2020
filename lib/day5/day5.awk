# par 1:
# awk -f day5.awk <aoc inputfile> | grep 'part1'
# part 2:
# awk -f day5.awk <aoc inputfile> | grep 'seatID=' | awk '{print $NF}' | sort -n | uniq | awk -f day5_part2.awk
BEGIN {
  T = "\t";
  MAXSEATID = -1;
}
{
  rec = $0;
  REC[++RC] = rec;
}
END {
  for( r = 1; r <= RC; r++ ) {
    rec = REC[r];
    airplanerowinfo = substr(rec,1,7);
    airplanecolumninfo = substr(rec,8,3);
    ri = compute(airplanerowinfo,0,127,"F","B");
    ci = compute(airplanecolumninfo,0,7,"L","R");
    seatID = 8*ri + ci;
    print("seatID=" T seatID);
    if( MAXSEATID < seatID) {
      MAXSEATID = seatID;
    }
  }
  print( "part1 solution:" MAXSEATID);
}

function compute(_rule,_l,_r,_ctrlLower,_ctrlUpper) {
  DONE = 0;
  LOWER = _l;
  UPPER = _r;
  for( _i = 1; _i <= length(_rule); _i++) {
    _ctrl = substr(_rule,_i,1);
    solve(LOWER,UPPER,(_ctrl == _ctrlLower ));
    #print( LOWER T UPPER T DONE );
  }
  if( LOWER != UPPER ){
    print("panic!");
    exit(1);
  }
  return(LOWER);
}

function solve(_l,_r,_lowerPart,_s) {
  _l = LOWER;
  _r = UPPER;
  _s = (_r - _l + 1) / 2;
  if( _lowerPart ) {
    _l = _l;
    _r = _l + _s - 1;
  } else {
    _r = _r;
    _l = _l + _s;
  }
  UPPER = _r;
  LOWER = _l;
  DONE = (UPPER == LOWER);
}
