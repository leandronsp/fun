initial_time = Time.now

8.times.map do |idx|
  Thread.new do
    puts "Thread #{idx}: #{Thread.current.object_id}"
    sleep 20
  end
end.each(&:join)

puts "Total time: #{Time.now - initial_time} seconds"
