 [![Build Status](https://secure.travis-ci.org/tdegrunt/bitset.png)](http://travis-ci.org/tdegrunt/bitset)

BitSet
======
This module implements an array of bits, that grows as needed. It can be used from both JavaScript: 

    var bs = new BitSet();

    for(var n = 0; n < 12; n++) {
      bs.set(n);
    }

    console.dir(bs);

as well as CoffeeScript:

    bs = new BitSet

    bs.set 1
    bs.clear 1

    console.log bs.toString()
  
Usage
-----
BitSets are very useful for realtime metrics. If you want to count the number of active users (CoffeeScript):

    # Somewhere in application code
    todaysUserCount = new Bitset
        
    # The User class
    class User
      @login: (userName, password) ->
        todaysUserCount.set @userId
        
    # In reporting code
    todaysUserCount.cardinality()
    
Documentation
-------------

* `BitSet#set(pos)` - sets the bit on position pos to true
* `BitSet#get(pos)` - returns whether the bit on position pos is set
* `BitSet#clear(pos)` - clears the bit on position pos
* `BitSet#length` - returns the logical length of the bitset
* `BitSet#wordLength` - returns the word-length of the bitset
* `BitSet#cardinality` - returns how many bits are set to true in the bitset
* `BitSet#toString` - returns a string representation of the bitset
* `BitSet#toBinaryString` - returns a binary string representation of the bitset
* `BitSet#or(bitset)` - OR's this bitset with the argument bitset
* `BitSet#and(bitset)` - AND's this bitset with the argument bitset
* `BitSet#andNot(bitset)` - ANDNOT's this bitset with the argument bitset
* `BitSet#xor(bitset)` - XOR's this bitset with the argument bitset

For details see src/bitset.coffee

Installation
------------
npm install bitset

Performance
-----------
It performs pretty well, you can try the performance.js in the support folder. This is the output with 100.000.000 bits:

    set 100000000 bits: 3173ms
    cardinality 100000000
    cardinality: 949ms

Tests
-----
Testing is done via the excellent [mocha](http://mochajs.org/) (cake test)

## License

    bitset is licensed under MIT license.

    Copyright (C) 2012-2014 Tom de Grunt <tom@degrunt.nl>

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
    of the Software, and to permit persons to whom the Software is furnished to do
    so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
