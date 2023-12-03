queue = Ractor.new do 
  loop do
    Ractor.yield(Ractor.receive)
  end
end

queue.send(1)
queue.send(2)
queue.send(3)

puts queue.take
puts queue.take
puts queue.take
