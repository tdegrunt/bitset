BitSet = require '../lib/bitset'

describe 'BitSet when first created', ->
  bs = new BitSet

  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordLength should be 0', ->
    bs.wordLength().should.eql 0
  it 'bitsPerWord should be 32', ->
    bs.bitsPerWord.should.eql 32
  it 'toBinaryString() should be 00000000000000000000000000000000', ->
    bs.toBinaryString().should.eql "00000000000000000000000000000000"
  it 'toBinaryString() length should be 32', ->
    bs.toBinaryString().length.should.eql 32
  it 'toString() should be {}', ->
    bs.toString().should.eql "{}"

describe 'BitSet with bit 0 set', ->
  bs = new BitSet
  bs.set 0

  it 'length should be 1', ->
    bs.length().should.eql 1
  it 'wordlength should be 1', ->
    bs.wordLength().should.eql 1
  it 'cardinality should be 1', ->
    bs.cardinality().should.eql 1
  it 'should return true for bit 0', ->
    bs.get(0).should.eql true
  it 'toBinaryString() should be 00000000000000000000000000000001', ->
    bs.toBinaryString().should.eql "00000000000000000000000000000001"
  it 'toBinaryString() length should be 32', ->
    bs.toBinaryString().length.should.eql 32
  it 'toString() should be {0}', ->
    bs.toString().should.eql "{0}"

describe 'BitSet with bit 0 and 32 set and cleared', ->
  bs = new BitSet
  bs.set 0
  bs.clear 0

  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordlength should be 0', ->
    bs.wordLength().should.eql 0
  it 'cardinality should be 0', ->
    bs.cardinality().should.eql 0
  it 'should return false for bit 1', ->
    bs.get(0).should.eql false
  it 'toBinaryString() should be 00000000000000000000000000000000', ->
    bs.toBinaryString().should.eql "00000000000000000000000000000000"
  it 'toBinaryString() length should be 32', ->
    bs.toBinaryString().length.should.eql 32
  it 'toString() should be {}', ->
    bs.toString().should.eql "{}"

describe 'BitSet with bit 0 and 32 set', ->
  bs = new BitSet
  bs.set 0
  bs.set 32

  it 'length should be 33', ->
    bs.length().should.eql 33
  it 'wordlength should be 2', ->
    bs.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bs.cardinality().should.eql 2
  it 'should return true for bits 0', ->
    bs.get(0).should.eql true
  it 'should return true for bits 32', ->
    bs.get(32).should.eql true
  it 'toBinaryString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bs.toBinaryString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toBinaryString() length should be 64', ->
    bs.toBinaryString().length.should.eql 64
  it 'toString() should be {0,32}', ->
    bs.toString().should.eql "{0,32}"

describe 'BitSet A with bit 0 set OR-ed with BitSet B with bit 32 set', ->
  bsa = new BitSet
  bsa.set 0
  
  bsb = new BitSet
  bsb.set 32
  bsa.or bsb
  
  it 'length should be 33', ->
    bsa.length().should.eql 33
  it 'wordLength should be 2', ->
    bsa.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bsa.cardinality().should.eql 2
  it 'should return true for bit 0', ->
    bsa.get(0).should.eql true
  it 'should return true for bit 32', ->
    bsa.get(32).should.eql true
  it 'toBinaryString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bsa.toBinaryString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toBinaryString() length should be 64', ->
    bsa.toBinaryString().length.should.eql 64
  it 'toString() should be {0,32}', ->
    bsa.toString().should.eql "{0,32}"

describe 'BitSet A with bit 0 set AND-ed with BitSet B with bit 32 set', ->
  bsa = new BitSet
  bsa.set 0

  bsb = new BitSet
  bsb.set 32
  bsa.and bsb

  it 'length should be 0', ->
    bsa.length().should.eql 0
  it 'wordLength should be 0', ->
    bsa.wordLength().should.eql 0
  it 'cardinality should be 0', ->
    bsa.cardinality().should.eql 0
  it 'should return false for bit 1 & false for bit 33', ->
    bsa.get(0).should.eql false
  it 'should return false for bit 33', ->
    bsa.get(32).should.eql false
  it 'toBinaryString() should be 00000000000000000000000000000000', ->
    bsa.toBinaryString().should.eql "00000000000000000000000000000000"
  it 'toBinaryString() length should be 32', ->
    bsa.toBinaryString().length.should.eql 32
  it 'toString() should be {}', ->
    bsa.toString().should.eql "{}"

describe 'BitSet A with bit 0 set ANDNOT-ed with BitSet B with bit 32 set', ->
  bsa = new BitSet
  bsa.set 0

  bsb = new BitSet
  bsb.set 32
  bsa.andNot bsb

  it 'length should be 1', ->
    bsa.length().should.eql 1
  it 'wordLength should be 1', ->
    bsa.wordLength().should.eql 1
  it 'cardinality should be 1', ->
    bsa.cardinality().should.eql 1
  it 'should return true for bit 1', ->
    bsa.get(0).should.eql true
  it 'should return false for bit 33', ->
    bsa.get(32).should.eql false
  it 'toBinaryString() should be 00000000000000000000000000000001', ->
    bsa.toBinaryString().should.eql "00000000000000000000000000000001"
  it 'toBinaryString() length should be 32', ->
    bsa.toBinaryString().length.should.eql 32
  it 'toString() should be {0}', ->
    bsa.toString().should.eql "{0}"

describe 'BitSet A with bit 0 & bit 1 set XOR-ed with BitSet B with bit 32 & bit 1 set', ->
  bsa = new BitSet
  bsa.set(0)
  bsa.set(1)

  bsb = new BitSet
  bsb.set(32)
  bsb.set(1)
  bsa.xor bsb

  it 'length should be 33', ->
    bsa.length().should.eql 33
  it 'wordLength should be 2', ->
    bsa.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bsa.cardinality().should.eql 2
  it 'should return true for bit 0', ->
    bsa.get(0).should.eql true
  it 'should return true for bit 32', ->
    bsa.get(32).should.eql true
  it 'toBinaryString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bsa.toBinaryString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toBinaryString() length should be 64', ->
    bsa.toBinaryString().length.should.eql 64
  it 'toString() should be {0,32}', ->
    bsa.toString().should.eql "{0,32}"
