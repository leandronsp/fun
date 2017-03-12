(ns clojure-euler.001_multiples_3_and_5)

(comment
  "If we list all the natural numbers below 10 that are multiples of 3 or 5,
  we get 3, 5, 6 and 9. The sum of these multiples is 23.
  Find the sum of all the multiples of 3 or 5 below 1000.")

(defn count-multiples-of
  [multiple number]
  (int (Math/floor (/ number multiple))))

(defn sum-multiples-of
  [multiple number]
  (let [countm (count-multiples-of multiple number)]
  (let [calc   (/ (+ multiple (* countm multiple)) 2.0)]
  (* countm calc))))

(defn sum_under
  [ceil]
  (let [number (- ceil 1)]
  (let [sum3   (sum-multiples-of 3 number)]
  (let [sum5   (sum-multiples-of 5 number)]
  (let [sum15  (sum-multiples-of 15 number)]
  (int (- (+ sum3 sum5) sum15)))))))
