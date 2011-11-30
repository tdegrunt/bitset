# **BitSet** implementation for JavaScript, written in CoffeeScript.
# It aims to be compatible with the [Java implementation](http://bit.ly/sem9RQ)
module.exports = class BitSet
  
  # Creates a BitSet with 32 bitsPerWord
  constructor: (@bitsPerWord = 32) ->
    @store = []

  # Sets the bit at position pos to 1
  set: (pos) ->
    @store[~~(pos/@bitsPerWord)] |= (1 << (pos % @bitsPerWord))

  # Clears the bit at position pos
  clear: (pos) ->
    @store[~~(pos/@bitsPerWord)] &= (0xFF ^ (1 << (pos % @bitsPerWord)));
    
  # Returns whether the bit at position pos is set (returns true or false)
  get: (pos) ->
    (@store[~~(pos/@bitsPerWord)] & (1 << (pos % @bitsPerWord))) != 0
  
  # Returns the logical length
  length: ->
    @store.length * @bitsPerWord
    
  # Returns the word length
  wordLength: ->
    @store.length

  # Returns the cardinality of the BitSet, ie the number of bits which are set to 1
  cardinality: ->
    sum = 0
    for pos in [0..@length()]
      sum++ if @get(pos)
    sum

  # Returns a string representation of the BitSet
  toString: ->
    (@store.map (word) -> word.toString(2)).join('')