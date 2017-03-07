function buildArray(arr, floor, ceil) {
  arr.push(floor)
  if (floor == ceil) {
    return arr;
  }
  return buildArray(arr, floor + 1, ceil);
}

function sumUnder(ceil) {
  array = buildArray([], 1, ceil - 1);
  return sum(array, 0)
}

function sum(array, acc) {
  if (array.length == 0) {
    return acc;
  }

  number = array[array.length - 1]

  if (number % 3 == 0 || number % 5 == 0) {
    return sum(tail(array), number + acc);
  }

  return sum(tail(array), acc);
}

function tail(array) {
  return array.slice(0, array.length - 1);
}

module.exports = {
  buildArray: buildArray,
  sumUnder: sumUnder,
  sum: sum,
  tail: tail
}
