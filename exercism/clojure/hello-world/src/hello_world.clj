(ns hello-world)

(defn hello
  ([] (hello "World"))
  ([name] (format "Hello, %s!" name))
)
