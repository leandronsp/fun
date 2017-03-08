function largest(ceil) {
  return Math.max.apply(null, factors(ceil));
}

function factors(ceil) {
  return primeFactors(2, ceil, []);
}

function primeFactors(start, number, acc) {
  if (number == start) {
    acc.push(start);
    return acc;
  }

  if (number % start == 0) {
    acc.push(start);
    return primeFactors(start, number / start, acc);
  } else {
    return primeFactors(start + 1, number, acc);
  }
}

module.exports = {
  factors: factors,
  largest: largest
}
