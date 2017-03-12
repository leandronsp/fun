(ns rna-transcription)

(defn transcript [nucleotide]
  (case (str nucleotide)
    "C" "G"
    "G" "C"
    "T" "A"
    "A" "U"
    (throw (AssertionError. "invalid DNA strand"))))

(defn to-rna [strand]
  (apply str
    (map transcript (seq (char-array strand)))))
