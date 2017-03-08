function sumUnder(ceil) {
  return sumFibo(1, 0, ceil, 0)
}

function sumFibo(current, previous, ceil, acc) {
  if (ceil <= 0) {
    return acc;
  }

  number = current + previous;

  if (number % 2 == 0) {
    return sumFibo(number, current, ceil - current, acc + number) ;
  } else {
    return sumFibo(number, current, ceil - current, acc);
  }
}


module.exports = {
  sumUnder: sumUnder,
  sumFibo: sumFibo
}
