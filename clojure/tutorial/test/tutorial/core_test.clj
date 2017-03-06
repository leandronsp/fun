(ns tutorial.core-test
  (:require [clojure.test :refer :all]
            [tutorial.core :refer :all]))

(deftest tutorial-test
  (testing "math"
    (is (= 3 (/ 9 3)))
    (is (= 2 (/ 10 5)))
    (is (= 10/3 (/ 10 3)))
    (is (= 3.3333333333333335 (/ 10 3.0)))
    (is (= 21 (+ 1 2 3 4 5 6)))
   )
)
