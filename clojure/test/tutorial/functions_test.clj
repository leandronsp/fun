(ns tutorial.functions-test
  (:require [clojure.test :refer :all]
            [tutorial.core :refer :all]))

(deftest tutorial-test
  (testing "functions"
    (def square(fn [x] (* x x)))
    (is (= 9 (square 3)))

    ;; define function using syntatic sugar
    (defn square [x] (* x x))
    (is (= 4 (square 2)))

    ;; the same square, anonymous
    (is (= 4 ((fn [x] (* x x)) 2)))
  )
)
