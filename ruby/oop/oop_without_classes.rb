Account = {
  properties: [:name, :balance],
  methods: {
    deposit: lambda do |context, amount|
      context[:state][:balance] += amount
    end,
    print_balance: lambda do |context|
      name    = context[:state][:name]
      balance = context[:state][:balance]

      puts "#{name}'s balance: #{balance}"
    end
  }
}

def new_instance(template, *args)
  state =
    template[:properties]
    .zip(args)
    .to_h

  template.merge(state: state)
end

def send_message(object, message, *args)
  return unless object[:methods].has_key?(message)

  object[:methods][message].call(object, *args)
end
