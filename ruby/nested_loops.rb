require 'faker'
require 'benchmark'

def generate_groups
  (1..1_000).map do |id|
    { id: id, name: Faker::Educator.primary_school }
  end
end

def generate_users(groups_ids)
  (1..1_000).map do |id|
    { id: id, name: Faker::Name.name, group: groups_ids.sample }
  end
end

groups = generate_groups
groups_ids = groups.map { |group| group[:id] }
users  = generate_users(groups_ids)

def count_using_nested_loops(groups, users)
  counters = {}

  for group in groups
    key = group[:name]

    counters[key] ||= 0

    for user in users
      if user[:group] == group[:id]
        counters[key] += 1
      end
    end
  end

  counters
end

def count_using_idx(groups, users)
  counters   = {}
  groups_idx = groups_counters_idx(users)

  for group in groups
    key = group[:name]

    counters[key] ||= 0
    counters[key] = groups_idx[group[:id]]
  end

  counters
end

# users :: { group_id => counter }
# e.g { 1 => 3, 2 => 1 }
def groups_counters_idx(users)
  acc = {}

  for user in users
    group_id = user[:group]

    acc[group_id] ||= 0
    acc[group_id] += 1
  end

  acc
end

Benchmark.bm do |x|
  x.report('nested loops') {  count_using_nested_loops(groups, users) }
  x.report('idx')          {  count_using_idx(groups, users) }
end
