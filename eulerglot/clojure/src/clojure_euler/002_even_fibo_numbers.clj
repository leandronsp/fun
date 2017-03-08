(ns clojure-euler.002_even_fibo_numbers)

(defn sum_fibo
  [curr prev ceil acc]
    (if (<= ceil 0)
      acc
      (if (zero? (rem (+ curr prev) 2))
        (recur (+ curr prev) curr (- ceil curr) (+ acc (+ curr prev)))
        (recur (+ curr prev) curr (- ceil curr) acc))))

(defn sum_under [ceil] (sum_fibo 1 0 ceil 0))
