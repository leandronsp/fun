#sleep 15

initial_time = Time.now

8.times do |idx|
  puts "Starting process #{idx}..."
  fork do
    sleep 20
    puts "Ending process #{idx}..."
  end
end

Process.waitall

puts "Total time: #{Time.now - initial_time} seconds"
