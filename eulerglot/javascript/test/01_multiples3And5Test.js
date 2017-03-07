var assert = require('assert');

function buildArray(arr, floor, ceil) {
  arr.push(floor)
  if (floor == ceil) {
    return arr;
  }
  return buildArray(arr, floor + 1, ceil);
}

function sumUnder(ceil) {
  array = buildArray([], 1, ceil - 1);
  return sumMultiples(array, 0)
}

function sumMultiples(array, acc) {
  if (array.length == 0) {
    return acc;
  }

  number = array[array.length - 1]

  if (number % 3 == 0 || number % 5 == 0) {
    return sumMultiples(tail(array), number + acc);
  }

  return sumMultiples(tail(array), acc);
}

function tail(array) {
  return array.slice(0, array.length - 1);
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
