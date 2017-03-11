(ns bob
  (:require [clojure.string :as str]))

(defn silence? [input] (= "" (str/trim input)))

(defn questioning? [input] (str/ends-with? input "?"))

(defn shouting? [input]
  (and
    (= input (str/upper-case input))
    (not= input (str/lower-case input))))

(defn response-for
  [input]
  (cond
    (silence? input) "Fine. Be that way!"
    (shouting? input) "Whoa, chill out!"
    (questioning? input) "Sure."
    :else "Whatever."))
