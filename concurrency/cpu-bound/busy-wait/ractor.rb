puts "Main process: #{Process.pid}"
puts "Main thread: #{Thread.current.object_id}"
puts "Main ractor: #{Ractor.current.object_id}"

def busy_wait(n)
  end_time = Time.now + n
  answer = 0

  while Time.now < end_time
    answer = 41 + 1
  end
end

initial_time = Time.now

8.times.map do |idx|
  Ractor.new(idx) do |idx|
    puts "Ractor #{idx}: #{Ractor.current.object_id}"
    t_initial_time = Time.now
    busy_wait(20)
    puts "Ractor #{idx} finished in #{Time.now - t_initial_time} seconds"
  end
end.each(&:take)

puts "Total time: #{Time.now - initial_time} seconds"
