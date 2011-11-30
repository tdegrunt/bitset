(function() {
  var BitSet;

  module.exports = BitSet = (function() {

    function BitSet(bitsPerWord) {
      this.bitsPerWord = bitsPerWord != null ? bitsPerWord : 32;
      this.store = [];
    }

    BitSet.prototype.set = function(pos) {
      return this.store[~~(pos / this.bitsPerWord)] |= 1 << (pos % this.bitsPerWord);
    };

    BitSet.prototype.clear = function(pos) {
      return this.store[~~(pos / this.bitsPerWord)] &= 0xFF ^ (1 << (pos % this.bitsPerWord));
    };

    BitSet.prototype.get = function(pos) {
      return (this.store[~~(pos / this.bitsPerWord)] & (1 << (pos % this.bitsPerWord))) !== 0;
    };

    BitSet.prototype.length = function() {
      return this.store.length * this.bitsPerWord;
    };

    BitSet.prototype.wordLength = function() {
      return this.store.length;
    };

    BitSet.prototype.cardinality = function() {
      var pos, sum, _ref;
      sum = 0;
      for (pos = 0, _ref = this.length(); 0 <= _ref ? pos <= _ref : pos >= _ref; 0 <= _ref ? pos++ : pos--) {
        if (this.get(pos)) sum++;
      }
      return sum;
    };

    BitSet.prototype.toString = function() {
      return (this.store.map(function(word) {
        return word.toString(2);
      })).join('');
    };

    return BitSet;

  })();

}).call(this);
