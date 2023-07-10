require 'test/unit'

def woodpecker_distribution(items)
  count = 0
  distribution = { woodpecker: [], fink_fox: [], picked: {} }

  for idx in 0...items.length
    count += 1 unless distribution[:picked][idx]
    next if distribution[:picked][idx]

    # Woodpecker share: only one item
    woodpecker_share = items[idx]
    distribution[:woodpecker].push(woodpecker_share)
    distribution[:picked][idx] = true

    # Fink fox share: N items
    count.times do |i|
      unfair_idx = idx + i + 1
      fink_fox_share = items[unfair_idx]

      if fink_fox_share
        distribution[:fink_fox].push(fink_fox_share)
        distribution[:picked][unfair_idx] = true
      else
        # Fink fox stole woodpecker share
        stole_share = distribution[:woodpecker].pop
        distribution[:fink_fox].push(stole_share)
      end
    end
  end

  distribution
end

class WoodpeckerAlgorithm < Test::Unit::TestCase
  def test_woodpecker_distribution_simple
    items = %w[milk bread butter cheese ham eggs bacon sausage beer]

    distribution = woodpecker_distribution(items)

    assert_equal(3, distribution[:woodpecker].length)
    assert_equal(6, distribution[:fink_fox].length)

    assert_equal(%w[milk butter eggs], distribution[:woodpecker])
    assert_equal(%w[bread cheese ham bacon sausage beer], distribution[:fink_fox])
  end

  def test_woodpecker_distribution_complex
    items = %w[milk bread butter cheese ham eggs bacon sausage beer wine
    juice water coffee tea sugar salt]

    distribution = woodpecker_distribution(items)

    assert_equal(1, distribution[:woodpecker].length)
    assert_equal(15, distribution[:fink_fox].length)

    assert_equal(%w[milk], distribution[:woodpecker])
    assert_equal(%w[bread cheese ham bacon sausage beer juice water coffee tea salt sugar wine eggs butter], distribution[:fink_fox])
  end
end

