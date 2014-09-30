# **BitSet** implementation for JavaScript, written in CoffeeScript.
# It aims to be compatible with the [Java implementation](http://bit.ly/sem9RQ)
module.exports = class BitSet
  
  HAMMING_TABLE = [ 
    0, # 0b0000
    1, # 0b0001
    1, # 0b0010
    2, # 0b0011
    1, # 0b0100
    2, # 0b0101
    2, # 0b0110
    3, # 0b0111
    1, # 0b1000
    2, # 0b1001
    2, # 0b1010
    3, # 0b1011
    2, # 0b1100
    3, # 0b1101
    3, # 0b1110
    4  # 0b1111
  ]

  constructor: ->
    @bitsPerWord = 32
    @addressBitsPerWord = 5
    @store = []

  # Given a bit position pos, return word index containing it
  wordIndex: (pos) ->
    pos >> @addressBitsPerWord

  # Sets the bit at position pos to true
  set: (pos) ->
    @store[@wordIndex(pos)] |= (1 << pos)

  # Clears the bit at position pos
  clear: (pos) ->
    @store[@wordIndex(pos)] &= (0xFF ^ (1 << pos))
    
  # Returns whether the bit at position pos is set (returns true or false)
  get: (pos) ->
    ((@store[@wordIndex(pos)] & (1 << pos)) != 0)
  
  # Returns the logical length of this BitSet: the index of the highest set bit plus one.
  # Returns zero if the BitSet contains no set bits
  length: ->
    if @wordLength() is 0
      0 
    else
      @bitsPerWord * (@wordLength()-1) + (@store[@wordLength()-1].toString(2).length)
    
  # Returns the number of words in use for this BitSet
  wordLength: ->
    length = @store.length
    for pos in [@store.length-1..0]
      break if @store[pos] isnt 0
      length--

    length

  # Returns the cardinality of the BitSet, ie the number of bits which are set to true
  cardinality: ->
    sum = 0
    for word in @store
      sum += HAMMING_TABLE[ (word >> 0x00) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x04) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x08) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x0C) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x10) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x14) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x18) & 0xF ]
      sum += HAMMING_TABLE[ (word >> 0x1C) & 0xF ]
    return sum

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
