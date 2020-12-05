BEGIN {
  T = "\t";
}
{
  seatID = $0;
  if( FNR > 1 ) {
    if( _last != (seatID - 1)) {
      # hopefully only once!
      missingseat = (_last + seatID) / 2;
      print( "part2 solution:" missingseat);
    }
  }
  _last = seatID;
}
