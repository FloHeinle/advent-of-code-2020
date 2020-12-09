# usage:
# awk -f day9.awk <aoc inputfile>
BEGIN {
  PREAMBLE = 25;
  T = "\t";
}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
  p1 = 0;
  p2 = 0;
  SUMALL = 0;
  MIN = REC[1]; MAX = MIN;
  for( r = 1; r <= RC; r++ ) {
    rec= REC[r];
    if( rec > MAX ) {
      MAX = rec;
    }
    if( rec < MIN ) {
      MIN = rec;
    }
    SUMALL += rec;
    SUMTO[r] = SUMALL;
    INITREC[r] = rec;
    if( !(rec in INRANGE )) {
      INRANGE[rec] = 0;
    }
  }
  for( r = 1; r <= RC; r++ ) {
    rec= REC[r];
    reset();
    if( !check(r) ) {
      p1 = rec;
      break;
    }
  }
  print( p1 );
  p2 = searchFor(p1);
  print( p2 );
}

function searchFor(_p) {
  _gotit = 0;
  for( _i = 2; !_gotit && (_i <= RC); _i++ ) {
    _x = SUMTO[_i-1];
    _idx = _i;
    for( _j = _i + 1; !_gotit && (_j <= RC); _j++ ) {
      _y = SUMTO[_j];
      _idy = _j;
      _gotit = ((_y - _x) == _p);
      }
      if( _gotit ) {
        _min = MAX;
        _max = MIN;
        for( _k = _idx; _k <= _idy; _k++) {
          _v = REC[_k];
          if( _v > _max) {
            _max = _v
          }
          if( _v < _min) {
            _min = _v;
          }
        }
        return(_min + _max);
      }
    }
}

function reset() {
  for( _k in INRANGE ) {
    INRANGE[_k] = 0;
  }
}

function check(_r) {
  _issum = 1;
  _s = _r - PREAMBLE;
  if( _s <= 0 ) {return _issum; }
  _toCheck = REC[_r]
  for( _i = _s; _i < (_s + PREAMBLE); _i++ ){
    _number = REC[_i];
    _idx = _i -_s + 1;
    N[_idx] = _number;
    INRANGE[_number] = _i;
  }
  for( _i = 1; _i <= PREAMBLE; _i++) {
    _number = N[_i];
    _d = _toCheck - _number;
    if( _d != _number ) {
      _issum = (_d in INRANGE);
      if( _issum ) {
        _issum = (INRANGE[_d]);
        if( _issum ) {
          break;
        }
      }
    }
  }
  return(_issum);
}
