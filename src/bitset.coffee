# **BitSet** implementation for JavaScript, written in CoffeeScript.
# It aims to be compatible with the [Java implementation](http://bit.ly/sem9RQ)
module.exports = class BitSet
  
  constructor: ->
    @bitsPerWord = 32
    @addressBitsPerWord = 5
    @bitIndexMask = @bitsPerWord - 1
    @store = []
    
  wordIndex: (bitIndex) ->
    bitIndex >> @addressBitsPerWord

  # Sets the bit at position pos to 1
  set: (pos) ->
    @store[@wordIndex(pos-1)] |= (1 << pos-1)

  # Clears the bit at position pos
  clear: (pos) ->
    @store[@wordIndex(pos-1)] &= (0xFF ^ (1 << pos-1))
    
  # Returns whether the bit at position pos is set (returns true or false)
  get: (pos) ->
    ((@store[@wordIndex(pos-1)] & (1 << pos-1)) != 0)
  
  # Returns the logical length
  length: ->
    if @wordLength() is 0
      0 
    else
      @bitsPerWord * (@wordLength()-1) + (@store[@wordLength()-1].toString(2).length+1)
    
  # Returns the word length
  wordLength: ->
    if @store.length is 1 and @store[0] is 0
      0
    else
      @store.length
    
  # Returns the store
  store: ->
    @store

  # Returns the cardinality of the BitSet, ie the number of bits which are set to 1
  cardinality: ->
    sum = 0
    for pos in [0..@length()]
      sum++ if @get(pos)
    sum

  # Returns a string representation of the BitSet
  toString: ->
    lpad = (str, padString, length) ->
      while str.length < length
        str = padString + str
      str
    
    if @store.length > 0
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