# usage:
# awk -f day7.awk <aoc inputfile>
BEGIN {
  T = "\t";
  FS = ",";
  SPACE = " ";
  MYBAG = "shiny_gold";
}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
 for( r = 1; r <= RC; r++ ) {
   rec= REC[r];
   collectBagTypesAndRelations(rec);
  }

  countMyPotentialContainerBags = 0;
  for( bag in BAGS ) {
    if( bag != MYBAG ) {
      _b = bagCouldContainMyBag(bag);
      if( _b ) {
        countMyPotentialContainerBags++;
      }
    }
  }
  requiredBags = calculateRequiredBags(MYBAG);
  print(countMyPotentialContainerBags);
  print(requiredBags);
}

function calculateRequiredBags(_bag,_ret,_childs,_carr,_cl,_ci,_child,_factor,_cr) {
  _ret = 0;
  if( _bag != MYBAG) {
    _ret = 1; # this bag is contained (in-)directly
  }
  # now include calculation for the childs
  _childs = RELATIONS[_bag];
  _cl = split(_childs,_carr,T);
  for( _ci = 1; _ci <= _cl; _ci++) {
    _child = _carr[_ci];
    _factor = NUMBEROFBAGS[_bag ":" _child];
    _cr = calculateRequiredBags(_child);
    _ret = _ret + _factor*_cr;
  }
  return(_ret);
}

function bagCouldContainMyBag(_bag,_ret,_childs,_carr,_cl,_ci,_child) {
  _ret = 0;
  _childs = RELATIONS[_bag];
  _cl = split(_childs,_carr,T);
  for( _ci = 1; _ci <= _cl; _ci++) {
    _child = _carr[_ci];
    if( _child == MYBAG ) { # got it
      _ret = 1;
      break;
    }
    else {
      # ok. my bag is not the son of _bag,
      # but may be the grandson, great-grandson...
      _ret = bagCouldContainMyBag(_child);
      if( _ret ) {
        break;
      }
    }
  }
  return(_ret);
}

# 1. create beautified names for the data entries
# 2. build relations (bag_in_bag)
function collectBagTypesAndRelations(rec, cn,_arr,_arr2,_al) {
  _l = split(rec,_arr,FS);
  _parentNode = "";
  for( _i = 1; _i <= _l; _i++) {
    cn = canonicalNames(_arr,_i);
    if( _i == 1 ) {
      if( !FINDCANONICALNAMES) {
        print("panic! no canonical name" T rec);
        exit(1);
      } else {
        _al = split(cn,_arr2,T);
        _parentNode = _arr2[1];
        if( _al == 2 ) {
          addRelation(_parentNode,_arr2[2])
        }
      }
    }
    else {
      addRelation(_parentNode,cn);
    }
  }
}

function addRelation(_p,_c) {
  BAGS[_p] = 1;
  BAGS[_c] = 1;

  _key = _p ":" _c;
  if( !(_key in NUMBEROFBAGS)) {
    print( "panic! no number of bags for relation " _key);
    exit(1);
  }

  if( !(_p in RELATIONS)) {
    RELATIONS[_p] = _c;
  } else {
    RELATIONS[_p] = RELATIONS[_p] T _c;
  }
}

function canonicalNames(_arr,_i) {
  _text = _arr[_i];
  _cn = "";
  _count = 0;
  FINDCANONICALNAMES = 0;
  if( _i == 1 ) {
      split( _text,_a1,"contain");
      split(_a1[1],_a2,SPACE);
      _cn = _a2[1] "_" _a2[2];
      PARENT = _cn;
      _temp = _a1[2];
      _temp2 = canonicalNameFromChildInfo(_temp);
      if( FINDCHILDINFO ) {
        _cn = _cn T _temp2;
      }
      FINDCANONICALNAMES = 1;
  } else {
    _cn = canonicalNameFromChildInfo(_text);
    FINDCANONICALNAMES = FINDCHILDINFO;
  }
  return(_cn);
}

function canonicalNameFromChildInfo(_cInfo,_parent, _ar,_arl,_result) {
  FINDCHILDINFO = match(_cInfo,"[ ]+[0-9]+");
  _result = "";
  if( FINDCHILDINFO ) {
    _arl = split(_cInfo,_ar,SPACE);
    _result = _ar[2] "_" _ar[3];
    _key = PARENT ":" _result;
    NUMBEROFBAGS[_key] = _ar[1];
  }
  return(_result);
}
