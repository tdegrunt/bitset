BitSet
======
This module implements an array of bits, that grows as needed. It can be used from both JavaScript as well as CoffeeScript.

    var bs = new BitSet(31);

    _(12).times(function(n){ 
      bs.set(n);
    });

    console.dir(bs);
 
Usage
-----
This is very useful for realtime metrics with for example Redis. 

Installation
------------
npm install bitset

Performance
-----------
It performs pretty well, you can try the performance.js in the support folder. This is the output with a 31 bit word size and 10.000.000 bits:

    set 10000000 bits: 418ms
    cardinality 10000000
    cardinality: 150ms

Tests
-----
Testing is done via mocha (cake test)