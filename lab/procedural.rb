@leandro_balance = 100
@john_balance = 200

def deposit(balance, amount)
  balance = balance + amount
end

deposit(@leandro_balance, 10)
deposit(@john_balance, 40)

puts "Leandro balance: #{@leandro_balance}"
# => 100
#
puts "John balance: #{@john_balance}"
# => 200
