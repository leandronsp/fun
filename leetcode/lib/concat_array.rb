module ConcatArray
  def concat(nums)
    length = nums.size

    for idx in 0...length
      nums[idx + length] = nums[idx]
    end

    nums
  end
end
