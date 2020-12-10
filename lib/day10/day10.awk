# usage:
# awk -f day10.awk <aoc inputfile>
BEGIN {
  T = "\t";
}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
  p1 = 0;
  p2 = 0;
  MAX = REC[1];
  for( r = 1; r <= RC; r++ ) {
    rec= REC[r];
    INITREC[r] = rec;
    if( rec > MAX ) {
      MAX = rec;
    }
    P2CHECKED[r] = 0;
  }
  REC[++RC] = MAX + 3;
  qsort(REC,1,RC);
  p1 = part1();
  RC--;
  p2 = part2();
  print( p1 );
  print( p2 );
}

function part1() {
  start_jolt = 0;
  for( r = 1; r <= RC; r++ ) {
    jolt = REC[r];
    diff = jolt - start_jolt;
    C[diff]++;
    start_jolt = jolt;
  }
  ret = C[1]*C[3];
  return(ret);
}

function part2() {
  _p = 0;
  S[RC] = 1;
  for( _r = RC-1; _r >= 1; _r--) {
    _jolt = REC[_r];
    _l = RC - _r;
    if( _l > 3 ) {
      _l = 3;
    }
    _nj1 = REC[_r+1];
    _nj2 = MAX + 3;
    _nj3 = _nj2;
    if( _l >= 2 ) {
      _nj2 = REC[_r+2];
    }
    if( _l == 3 ) {
      _nj3 = REC[_r+3];
    }
    _s = 0;
    if( (_nj1 - _jolt) <= 3) {
      _s = S[_r+1];
    }
    if( (_nj2 - _jolt) <= 3) {
      _s = _s + S[_r+2];
    }
    if( (_nj3 - _jolt) <= 3) {
      _s = _s + S[_r+3];
    }
    S[_r] = _s
  }
  for( _i = 1; _i < RC; _i++) {
    if( REC[_i] <= 3 )
      _p = _p + S[_i];
  }
  return(_p);
}

function qsort(A,left,right,   i,last) {
     if (left >= right)  # do nothing if array contains
         return          # at most one element
     swap(A, left, left + int((right-left+1)*rand()))
     last = left
     for (i = left+1; i <= right; i++)
         if (A[i] < A[left])
             swap(A, ++last, i)
     swap(A, left, last)
     qsort(A, left, last-1)
     qsort(A, last+1, right)
}

function swap(A,i,j,   t) {
     t = A[i]; A[i] = A[j]; A[j] = t
}
