queue = Ractor.new do 
  loop do
    Ractor.yield(Ractor.receive)
  end
end

data = ["My", "message"]
queue.send(data, move: true) # <---- move the object

# Error: Ractor::MovedError
# cannot send any methods to a moved object
puts "Data was sent: #{data.join}"
