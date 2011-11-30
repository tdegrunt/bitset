BitSet = require '../lib/bitset'

describe 'BitSet when first created', ->
  bs = new BitSet
  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordLength should be 0', ->
    bs.wordLength().should.eql 0
  it 'bitsPerWord should be 32', ->
    bs.bitsPerWord.should.eql 32

describe 'BitSet with bit 1 set', ->
  bs = new BitSet
  bs.set(1)
  it 'length should be 32', ->
    bs.length().should.eql 32
  it 'wordlength should be 1', ->
    bs.wordLength().should.eql 1
  it 'cardinality should be 1', ->
    bs.cardinality().should.eql 1
  it 'should return true for bit 1', ->
    bs.get(1).should.eql true

describe 'BitSet with bit 1 and 33 set', ->
  bs = new BitSet
  bs.set(1)
  bs.set(33)
  it 'length should be 64', ->
    bs.length().should.eql 64
  it 'wordlength should be 2', ->
    bs.wordLength().should.eql 2
  it 'cardinality should be 2', ->
    bs.cardinality().should.eql 2
  it 'should return true for bits 1 and 33', ->
    bs.get(1).should.eql true
    bs.get(33).should.eql true


describe 'BitSet with 16 bits per word when first created', ->
  bs = new BitSet 16
  it 'length should be 0', ->
    bs.length().should.eql 0
  it 'wordLength should be 0', ->
    bs.wordLength().should.eql 0
  it 'bitsPerWord should be 16', ->
    bs.bitsPerWord.should.eql 16


