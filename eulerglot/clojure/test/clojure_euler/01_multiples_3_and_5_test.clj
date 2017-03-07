(ns clojure-euler.01_multiples_3_and_5-test
  (:require [clojure.test :refer :all]
            [clojure-euler.01_multiples_3_and_5 :refer :all]))

(deftest test-01
  (testing "sum multiples under 10"
    (is (= 23 (sum_under 10))))

  (testing "sum multiples under 1000"
    (is (= 233168 (sum_under 1000)))))
