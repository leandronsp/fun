puts "Main process: #{Process.pid}"

@answer = 0

def busy_wait(n)
  end_time = Time.now + n

  while Time.now < end_time
    @answer = 41 + 1
  end
end

#busy_wait(15)

initial_time = Time.now

8.times do |idx|
  fork do
    puts "Forking process: #{Process.pid}"
    p_initial_time = Time.now
    busy_wait(20)
    puts "Forking process #{idx} finished in #{Time.now - p_initial_time} seconds"
  end
end

Process.waitall

puts "Total time: #{Time.now - initial_time} seconds"
