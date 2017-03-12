(ns clojure-euler.001_multiples_3_and_5)

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
