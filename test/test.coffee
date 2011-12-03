BitSet = require '../lib/bitset'

describe 'BitSet when first created', ->
  bs = new BitSet
  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordLength should be 0', ->
    bs.wordLength().should.eql 0
  it 'bitsPerWord should be 32', ->
    bs.bitsPerWord.should.eql 32
  it 'toString() should be 00000000000000000000000000000000', ->
    bs.toString().should.eql "00000000000000000000000000000000"
  it 'toString() length should be 32', ->
    bs.toString().length.should.eql 32
     
describe 'BitSet with bit 1 set', ->
  bs = new BitSet
  bs.set(1)
  it 'length should be 2', ->
    bs.length().should.eql 2
  it 'wordlength should be 1', ->
    bs.wordLength().should.eql 1
  it 'cardinality should be 1', ->
    bs.cardinality().should.eql 1
  it 'should return true for bit 1', ->
    bs.get(1).should.eql true
  it 'toString() should be 00000000000000000000000000000001', ->
    bs.toString().should.eql "00000000000000000000000000000001"
  it 'toString() length should be 32', ->
    bs.toString().length.should.eql 32
  
describe 'BitSet with bit 1 set and cleared', ->
  bs = new BitSet
  bs.set(1)
  bs.clear(1)
  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordlength should be 0', ->
    bs.wordLength().should.eql 0
  it 'cardinality should be 0', ->
    bs.cardinality().should.eql 0
  it 'should return false for bit 1', ->
    bs.get(1).should.eql false
  it 'toString() should be 00000000000000000000000000000000', ->
    bs.toString().should.eql "00000000000000000000000000000000"
  it 'toString() length should be 32', ->
    bs.toString().length.should.eql 32

describe 'BitSet with bit 1 and 33 set', ->
  bs = new BitSet
  bs.set(1)
  bs.set(33)
  it 'length should be 34', ->
    bs.length().should.eql 34
  it 'wordlength should be 2', ->
    bs.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bs.cardinality().should.eql 2
  it 'should return true for bits 1', ->
    bs.get(1).should.eql true
  it 'should return true for bits 33', ->
    bs.get(33).should.eql true
  it 'toString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bs.toString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toString() length should be 64', ->
    bs.toString().length.should.eql 64

describe 'BitSet A with bit 1 set OR-ed with BitSet B with bit 33 set', ->
  bsa = new BitSet
  bsa.set(1)
  
  bsb = new BitSet
  bsb.set(33)
  bsa.or bsb
  
  it 'length should be 34', ->
    bsa.length().should.eql 34
  it 'wordLength should be 2', ->
    bsa.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bsa.cardinality().should.eql 2
  it 'should return true for bit 1 & bit 33', ->
    bsa.get(1).should.eql true
  it 'should return true for bit 33', ->
    bsa.get(33).should.eql true
  it 'toString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bsa.toString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toString() length should be 64', ->
    bsa.toString().length.should.eql 64

describe 'BitSet A with bit 1 set AND-ed with BitSet B with bit 33 set', ->
  bsa = new BitSet
  bsa.set(1)

  bsb = new BitSet
  bsb.set(33)
  bsa.and bsb

  it 'length should be 34', ->
    bsa.length().should.eql 34
  it 'wordLength should be 2', ->
    bsa.wordLength().should.eql 2
  it 'cardinality should be 0', ->
    bsa.cardinality().should.eql 0
  it 'should return false for bit 1 & false for bit 33', ->
    bsa.get(1).should.eql false
  it 'should return false for bit 33', ->
    bsa.get(33).should.eql false
  it 'toString() should be 0000000000000000000000000000000000000000000000000000000000000000', ->
    bsa.toString().should.eql "0000000000000000000000000000000000000000000000000000000000000000"
  it 'toString() length should be 64', ->
    bsa.toString().length.should.eql 64

describe 'BitSet A with bit 1 set ANDNOT-ed with BitSet B with bit 33 set', ->
  bsa = new BitSet
  bsa.set(1)

  bsb = new BitSet
  bsb.set(33)
  bsa.andNot bsb

  it 'length should be 2', ->
    bsa.length().should.eql 2
  it 'wordLength should be 1', ->
    bsa.wordLength().should.eql 1
  it 'cardinality should be 1', ->
    bsa.cardinality().should.eql 1
  it 'should return true for bit 1', ->
    bsa.get(1).should.eql true
  it 'should return false for bit 33', ->
    bsa.get(33).should.eql false
  it 'toString() should be 00000000000000000000000000000001', ->
    bsa.toString().should.eql "00000000000000000000000000000001"
  it 'toString() length should be 32', ->
    bsa.toString().length.should.eql 32

describe 'BitSet A with bit 1 & bit 2 set XOR-ed with BitSet B with bit 33 & bit 2 set', ->
  bsa = new BitSet
  bsa.set(1)
  bsa.set(2)

  bsb = new BitSet
  bsb.set(33)
  bsb.set(2)
  bsa.xor bsb

  it 'length should be 34', ->
    bsa.length().should.eql 34
  it 'wordLength should be 2', ->
    bsa.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bsa.cardinality().should.eql 2
  it 'should return true for bit 1', ->
    bsa.get(1).should.eql true
  it 'should return true for bit 33', ->
    bsa.get(33).should.eql true
  it 'toString() should be 0000000000000000000000000000000100000000000000000000000000000001', ->
    bsa.toString().should.eql "0000000000000000000000000000000100000000000000000000000000000001"
  it 'toString() length should be 64', ->
    bsa.toString().length.should.eql 64
