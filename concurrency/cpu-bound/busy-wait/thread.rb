puts "Main process: #{Process.pid}"
puts "Main thread: #{Thread.current.object_id}"

@answer = 0

def busy_wait(n)
  end_time = Time.now + n

  while Time.now < end_time
    @answer = 41 + 1
  end
end

initial_time = Time.now

8.times.map do |idx|
  Thread.new do
    puts "Thread #{idx}: #{Thread.current.object_id}"
    t_initial_time = Time.now
    busy_wait(20)
    puts "Thread #{idx} finished in #{Time.now - t_initial_time} seconds"
  end
end.each(&:join)

puts "Total time: #{Time.now - initial_time} seconds"
