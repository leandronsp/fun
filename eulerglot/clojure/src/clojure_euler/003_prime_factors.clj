(ns clojure-euler.003_prime_factors)

(comment "The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?")

(defn factor-by
  [number multiple]
  (if (not= 0 (rem number multiple))
    number
    (recur (/ number multiple) multiple)))

(defn factor-by-prime
  [number prime largest]
  (if (> prime (Math/sqrt number))
    [number largest]
    (recur (factor-by number prime) (+ prime 2) prime)))

(defn largest
  [ceil]
  (let [number (factor-by ceil 2)]
  (let [result (factor-by-prime number 3 0)]
  (let [number (nth result 0) largest (nth result 1)]
  (if (> number 2) number largest)))))
