(ns clojure-euler.003_prime_factors)

(defn prime_factors
  [start number acc]
    (if (= number start)
      (concat acc [start])
      (if (zero? (rem number start))
        (recur start (/ number start) (concat acc [start]))
        (recur (+ start 1) number acc))))

(defn largest [ceil] (apply max (prime_factors 2 ceil [])))
