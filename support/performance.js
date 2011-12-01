var BitSet = require('./lib/bitset');
var _ = require('underscore');

var NR_OF_BITS=10000000;

var bs = new BitSet(31);

console.time("set "+NR_OF_BITS+" bits");
_(NR_OF_BITS).times(function(n){ 
  bs.set(n);
});

console.timeEnd("set "+NR_OF_BITS+" bits");

console.time("cardinality");
console.log("cardinality", bs.cardinality());
console.timeEnd("cardinality");
