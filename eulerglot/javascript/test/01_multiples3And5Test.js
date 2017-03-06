var assert = require('assert');

function buildArray(arr, floor, ceil) {
  arr.push(floor)
  if (floor == (ceil - 1)) {
    return arr;
  }
  return buildArray(arr, floor + 1, ceil);
}

function sumUnder(ceil) {
  array     = buildArray([], 1, ceil);
  multiples = array.filter(function(number) {
    return (number % 3) == 0 || (number % 5) == 0
  });

  return multiples.reduce(function(acc, number) {
    return acc + number;
  });
}

describe('multiples of 3 and 5', function() {
  it('sums all multiples of 3 and 5 under 10', function() {
    sum = sumUnder(10);
    assert.equal(sum, 23);
  });

  it('sums all multiples of 3 and 5 under 1000', function() {
    sum = sumUnder(1000);
    assert.equal(sum, 233168);
  });
});
