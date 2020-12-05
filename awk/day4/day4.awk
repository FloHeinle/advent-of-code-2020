# usage:
# part 1
# awk -f day4.awk -v PART_1=1 <aoc inputfile>
# part 2
# awk -f day4.awk -v PART_1=0 <aoc inputfile>

BEGIN {
  T = "\t";
  ROW = "";

  MINV["byr"] = 1920;
  MAXV["byr"] = 2002;
  MINV["iyr"] = 2010;
  MAXV["iyr"] = 2020;
  MINV["eyr"] = 2020;
  MAXV["eyr"] = 2030;

  ECL["amb"] = 1;
  ECL["blu"] = 1;
  ECL["brn"] = 1;
  ECL["gry"] = 1;
  ECL["grn"] = 1;
  ECL["hzl"] = 1;
  ECL["oth"] = 1;

}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
  M = 0;
  V = 0;
  REC[++RC] = ""; # makes handling of last row easier
  for( r = 1; r <= RC; r++ ) {
    _r = REC[r];
    build(_r);
  }
  for( _ri = 1; _ri <= ROWCOUNT; _ri++) {
    row = R[_ri];
    n = checkRow(row);
    if( n > M ) {M = n;}
    if( n == 7 ){
      SOLUTION++;
    }
  }
  if( PART_1 ) {
      print( "part1 solution:" SOLUTION);
  } else {
      print( "part2 solution:" SOLUTION);
  }
}

function build(_r) {
  if( match(_r,"^$")) {
    if( ROW != "" ) {
      sub("^[ ]+","",ROW);
      R[++ROWCOUNT] = ROW;
    }
    ROW = "";
  }
  else {
    ROW = ROW " " _r;
  }
}

function checkRow(row) {
  numattr = 0;
  x = "";
  for( a in B ) {
    delete B[a];
  }
  l = split(row,arr);
  for( i = 1; i <= l; i++ ) {
    attr = arr[i];
    split(attr,arr2,":");
    attr = arr2[1];
    attr_value = arr2[2];
    if( i == 1 ) {
      x = attr;
    }
    else {
      x = x T attr;
    }
    if( !(attr in B)) {
      if( attr != "cid") {
        B[attr] = attr_value;
        if( valid(attr,attr_value)) {
          numattr++;
        }
      }
    }
    else {
      print( "ERR" T  attr T r);
      exit(1);
    }
  }
  return(numattr);
}

function valid(attr,attr_value) {
  if( PART_1 ) {
    return 1;
  }
  iv = 0;
  if( attr in MINV ) {
    iv = match(attr_value,"[0-9][0-9][0-9][0-9]");
    if( iv ) {
      iv = ((attr_value >= MINV[attr]) && (attr_value <= MAXV[attr]));
    }
  }
  else if( attr == "hgt" ) {
    iv = match(attr_value,"^[0-9]+(cm|in)$");
    if( iv ) {
      tmpav = attr_value;
      iscm = sub("cm","",tmpav);
      isin = sub("in","",tmpav);
      match(attr_value,"^[0-9]+");
      size = substr(attr_value,RSTART,RLENGTH);
      if( iscm ) {
        iv = (size >= 150) && (size <= 193);
      }
      else if( isin ) {
        iv = (size >= 59) && (size <= 76);
      }
    }
  }
  else if( attr == "hcl" ) {
    tmpav = attr_value;
    iv = gsub("^#","",tmpav);
    iv = iv && (length(tmpav) == 6);
    iv = iv && match(tmpav,"^([0-9]|[a-f])+$");
  }
  else if( attr == "ecl" ) {
    iv = (attr_value in ECL);
  }
  else if( attr == "pid" ) {
    iv = (length(attr_value) == 9);
    iv = iv && match(attr_value,"^[0-9]+$");
  }
  return(iv);
}
