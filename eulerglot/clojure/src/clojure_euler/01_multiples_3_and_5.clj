(ns clojure-euler.01_multiples_3_and_5)

(defn sum_under
  [ceil]
  (loop [number 0 acc 0]
    (if (> ceil number)
      (recur (inc number)
        (if (or (zero? (rem number 3)) (zero? (rem number 5)))
          (+ acc number)
          acc))
      acc)))
