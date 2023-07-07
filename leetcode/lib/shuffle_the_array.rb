module ShuffleTheArray
  def shuffle(nums, n)
    result = []

    n.times do |idx|
      result << nums[idx]
      result << nums[idx + n]
    end

    result
  end
end
