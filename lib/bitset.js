(function() {
  var BitSet;

  module.exports = BitSet = (function() {

    function BitSet() {
      this.bitsPerWord = 32;
      this.addressBitsPerWord = 5;
      this.bitIndexMask = this.bitsPerWord - 1;
      this.store = [];
    }

    BitSet.prototype.wordIndex = function(bitIndex) {
      return bitIndex >> this.addressBitsPerWord;
    };

    BitSet.prototype.set = function(pos) {
      return this.store[this.wordIndex(pos - 1)] |= 1 << pos - 1;
    };

    BitSet.prototype.clear = function(pos) {
      return this.store[this.wordIndex(pos - 1)] &= 0xFF ^ (1 << pos - 1);
    };

    BitSet.prototype.get = function(pos) {
      return (this.store[this.wordIndex(pos - 1)] & (1 << pos - 1)) !== 0;
    };

    BitSet.prototype.length = function() {
      if (this.wordLength() === 0) {
        return 0;
      } else {
        return this.bitsPerWord * (this.wordLength() - 1) + (this.store[this.wordLength() - 1].toString(2).length + 1);
      }
    };

    BitSet.prototype.wordLength = function() {
      if (this.store.length === 1 && this.store[0] === 0) {
        return 0;
      } else {
        return this.store.length;
      }
    };

    BitSet.prototype.store = function() {
      return this.store;
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
      var lpad;
      var _this = this;
      lpad = function(str, padString, length) {
        while (str.length < length) {
          str = padString + str;
        }
        return str;
      };
      if (this.store.length > 0) {
        return this.store.map(function(word) {
          return lpad(word.toString(2), '0', _this.bitsPerWord);
        }).join('');
      } else {
        return lpad('', 0, this.bitsPerWord);
      }
    };

    BitSet.prototype.or = function(set) {
      var pos, wordsInCommon, _ref;
      if (this === set) return;
      wordsInCommon = Math.min(this.wordLength(), set.wordLength());
      for (pos = 0, _ref = wordsInCommon - 1; 0 <= _ref ? pos <= _ref : pos >= _ref; 0 <= _ref ? pos++ : pos--) {
        this.store[pos] |= set.store[pos];
      }
      if (wordsInCommon < set.wordLength()) {
        this.store = this.store.concat(set.store.slice(wordsInCommon, set.wordLength()));
      }
      return null;
    };

    BitSet.prototype.and = function(set) {
      var pos, _ref, _ref2, _ref3;
      if (this === set) return;
      for (pos = _ref = this.wordLength, _ref2 = set.wordLength(); _ref <= _ref2 ? pos <= _ref2 : pos >= _ref2; _ref <= _ref2 ? pos++ : pos--) {
        this.store[pos] = 0;
      }
      for (pos = 0, _ref3 = this.wordLength(); 0 <= _ref3 ? pos <= _ref3 : pos >= _ref3; 0 <= _ref3 ? pos++ : pos--) {
        this.store[pos] &= set.store[pos];
      }
      return null;
    };

    BitSet.prototype.andNot = function(set) {
      var pos, _ref;
      for (pos = 0, _ref = Math.min(this.wordLength(), set.wordLength) - 1; 0 <= _ref ? pos <= _ref : pos >= _ref; 0 <= _ref ? pos++ : pos--) {
        this.store[pos] &= ~set.store[pos];
      }
      return null;
    };

    BitSet.prototype.xor = function(set) {
      var pos, _ref;
      if (this === set) return;
      for (pos = 0, _ref = this.wordLength(); 0 <= _ref ? pos <= _ref : pos >= _ref; 0 <= _ref ? pos++ : pos--) {
        this.store[pos] ^= set.store[pos];
      }
      return null;
    };

    return BitSet;

  })();

}).call(this);
