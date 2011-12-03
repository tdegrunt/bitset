[![Build Status](https://secure.travis-ci.org/tdegrunt/bitset.png)](http://travis-ci.org/tdegrunt/bitset)

BitSet
======
This module implements an array of bits, that grows as needed. It can be used from both JavaScript as well as CoffeeScript.

    var bs = new BitSet();

    _(12).times(function(n){ 
      bs.set(n);
    });

    console.dir(bs);

Mind you: The example uses [underscore.js](http://documentcloud.github.com/underscore/)
 
Usage
-----
This is very useful for realtime metrics with for example Redis.

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
Testing is done via the excellent [mocha](http://visionmedia.github.com/mocha) (cake test)