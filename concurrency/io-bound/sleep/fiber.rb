initial_time = Time.now

8.times.map do |idx|
  Fiber.new do
    puts "Fiber #{idx}: #{Fiber.current.object_id}"
    sleep 20
  end
end.each(&:resume)

puts "Total time: #{Time.now - initial_time} seconds"
