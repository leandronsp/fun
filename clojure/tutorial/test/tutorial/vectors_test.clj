(ns tutorial.vectors-test
  (:require [clojure.test :refer :all]
            [tutorial.core :refer :all]))


(deftest tutorial-test
  (testing "vectors"
    (is (= [2 3 4 5] (map inc [1 2 3 4])))
  )
)
