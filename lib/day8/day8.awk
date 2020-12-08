# usage:
# awk -f day8.awk <aoc inputfile>
BEGIN {
  ACCUMULATOR = 0;
  T = "\t";
  ACC = "acc";
  NOP = "nop";
  JMP = "jmp";
  FIN = "fin"; # my smart machine instruction
}
{
  _r = $0;
  REC[++RC] = _r;
}
END {
  REC[++RC] = FIN " +0"; # add a finalizer instruction
  for( r = 1; r <= RC; r++ ) {
    rec= REC[r];
    INITREC[r] = rec;
    opData(rec);
    if( INSTRUCTION == NOP ) {
      NOPPOS[++NOPS] = r;
    }
    if( INSTRUCTION == JMP ) {
      JMPPOS[++JMPS] = r;
    }
  }
  reset();
  prepareRun();
  run();
  print(ACCUMULATOR); # part 1
  # now brute force approach
  for( n = 1; (n <= NOPS) && !FINISHED; n++ ) {
    reset();
    idx = NOPPOS[n];
    rec = REC[idx];
    sub(NOP,JMP,rec);
    REC[idx] = rec;
    prepareRun();
    run();
    if( FINISHED ) {
      print( ACCUMULATOR ); # part 2
    }
  }
  for( n = 1; (n <= JMPS) && !FINISHED; n++ ) {
    reset();
    idx = JMPPOS[n];
    rec = REC[idx];
    sub(JMP,NOP,rec);
    REC[idx] = rec;
    prepareRun();
    run();
    if( FINISHED ) {
      print( ACCUMULATOR ); # part 2
    }
  }

}



function reset() {
  INFINITELOOPDETECTED = 0;
  FINISHED = 0;
  ACCUMULATOR = 0;
  for( r = 1; r <= RC; r++ ) {
    rec = INITREC[r];
    REC[r] = rec;
  }

}

function prepareRun() {
  for( r = 1; r <= RC; r++ ) {
   rec= REC[r];
   opData(rec);
   M_I[r] = INSTRUCTION;
   M_D[i] = DIRECTION;
   M_O[r] = OFFSET;
   NUMINSTRUCTIONINVOCATIONS[r] = 0;
  }
}

function opData(_rec) {
  split(_rec,arr," ");
  INSTRUCTION = arr[1];
  v = arr[2];
  DIRECTION = substr(v,1,1);
  OFFSET = substr(v,2,length(v) - 1);
  if( DIRECTION == "-" ) {
    OFFSET = -1*OFFSET;
  }
}

function run() {
  CURRINSTIDX = 1;
  while( !INFINITELOOPDETECTED && !FINISHED) {
      exec();
      if( !INFINITELOOPDETECTED ) {
        INSTIDX = CURRINSTIDX;
      }
  }
}

# exec one instruction
function exec( ) {
  NUMINSTRUCTIONINVOCATIONS[CURRINSTIDX]++;
  _n = NUMINSTRUCTIONINVOCATIONS[CURRINSTIDX];
  if( _n == 2 ) {
    INFINITELOOPDETECTED = 1;
  }
  else {
    _inst = M_I[CURRINSTIDX];
    _offset = M_O[CURRINSTIDX];
    if( _inst == ACC ) {
        ACCUMULATOR += _offset;
        CURRINSTIDX++;
    } else if( _inst == JMP ) {
      CURRINSTIDX += _offset
    } else  if( _inst == NOP ){
      CURRINSTIDX++
    } else {
      if( _inst != FIN ) {
        print( "panic! expect " FIN " but get " _inst);
      }
      FINISHED = 1;
    }
  }
}
