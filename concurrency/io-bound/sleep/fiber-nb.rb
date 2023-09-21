initial_time = Time.now

@waiting = []

def nonblocking_sleep(duration)
  delay_until = Time.now + duration

  @waiting << [Fiber.current, delay_until]
  @waiting.sort_by! { |_, time| time }

  Fiber.yield
end

8.times.map do |idx|
  Fiber.new do
    fiber_id = Fiber.current.object_id
    puts "Fiber #{idx}: #{fiber_id}"

    nonblocking_sleep(20)
    #sleep 20
  end
end.each(&:resume)

while @waiting.any? 
  if @waiting.first.last <= Time.now
    fiber, _ = @waiting.shift
    fiber.resume 
  end

  sleep 0.05
end

puts "Total time: #{Time.now - initial_time} seconds"
