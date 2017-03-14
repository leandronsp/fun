(ns word-count
  (:require [clojure.string :as str]))

(defn update-word
  [word acc]
  (let [valid (re-find #"\w+-?\w*" (str/lower-case word))]
  (if (nil? valid)
    acc
    (update acc valid (fnil inc 0)))))

(defn do-word-count
  [words acc]
  (let [word (first words)]
  (let [tail (rest words)]
  (if (empty? tail)
    (update-word word acc)
    (recur tail (update-word word acc))))))

(defn word-count
  [sentence]
  (let [words (str/split sentence #" ")]
  (do-word-count words {})))
