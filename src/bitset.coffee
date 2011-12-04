# **BitSet** implementation for JavaScript, written in CoffeeScript.
# It aims to be compatible with the [Java implementation](http://bit.ly/sem9RQ)
module.exports = class BitSet
  
  constructor: ->
    @bitsPerWord = 32
    @addressBitsPerWord = 5
    @store = []

  # Given a bit position pos, return word index containing it
  wordIndex: (pos) ->
    pos >> @addressBitsPerWord

  # Sets the bit at position pos to true
  set: (pos) ->
    @store[@wordIndex(pos-1)] |= (1 << pos-1)

  # Clears the bit at position pos
  clear: (pos) ->
    @store[@wordIndex(pos-1)] &= (0xFF ^ (1 << pos-1))
    
  # Returns whether the bit at position pos is set (returns true or false)
  get: (pos) ->
    ((@store[@wordIndex(pos-1)] & (1 << pos-1)) != 0)
  
  # Returns the logical length of this BitSet: the index of the highest set bit plus one.
  # Returns zero if the BitSet contains no set bits
  length: ->
    if @wordLength() is 0
      0 
    else
      @bitsPerWord * (@wordLength()-1) + (@store[@wordLength()-1].toString(2).length+1)
    
  # Returns the number of words in use for this BitSet
  wordLength: ->
    length = @store.length
    for pos in [@store.length-1..0]
      break if @store[pos] isnt 0
      length--

    length
    
  # Returns the bit-store
  store: ->
    @store

  # Returns the cardinality of the BitSet, ie the number of bits which are set to true
  cardinality: ->
    sum = 0
    for pos in [0..@length()]
      sum++ if @get(pos)
    sum

  # Returns a string representation of this bitset. For every bit set to true, it will include
  # a decimal representation in the result.
  toString: ->
    result = []
    for pos in [0..@length()]
      result.push pos if @get(pos)
    "{#{result.join(",")}}"

  # Returns a binary string representation of the BitSet
  toBinaryString: ->
    lpad = (str, padString, length) ->
      while str.length < length
        str = padString + str
      str
    
    if @wordLength() > 0
      @store.map( (word) => lpad(word.toString(2), '0', @bitsPerWord)).join('')
    else
      lpad('', 0, @bitsPerWord)
    
  # Performs a logical OR of this BitSet and the argument BitSet
  or: (set) -> 
    return if @ is set
    wordsInCommon = Math.min @wordLength(), set.wordLength()
    
    # Perform logical OR on words in common
    for pos in [0..wordsInCommon-1]
      @store[pos] |= set.store[pos]
      
    if wordsInCommon < set.wordLength()
      @store = @store.concat set.store.slice wordsInCommon, set.wordLength()
    
    null    
    
  # Performs a logical AND of this BitSet and the argument BitSet
  and: (set) -> 
    return if @ is set
    
    for pos in [@wordLength..set.wordLength()]
      @store[pos] = 0

    # Perform logical AND on words in common
    for pos in [0..@wordLength()]
      @store[pos] &= set.store[pos]
    null

  # Performs a logical ANDNOT of this BitSet and the argument BitSet
  andNot: (set) -> 
    # Perform logical ANDNOT on words in common
    for pos in [0..Math.min(@wordLength(), set.wordLength)-1]
      @store[pos] &= ~set.store[pos]
    null

  # Performs a logical XOR of this BitSet and the argument BitSet
  xor: (set) -> 
    return if @ is set

    # Perform logical XOR on words in common
    for pos in [0..@wordLength()]
      @store[pos] ^= set.store[pos]
    null