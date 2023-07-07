module SmallerNumbers
  def smaller_numbers(nums)
    sorted = nums.sort # Quicksort O(n log n)

    nums.map { |num| bsearch(sorted, num) }
  end

  # O (log n)
  def bsearch(nums, target, lowest_idx = 0, highest_idx = nums.length)
    found_idx = nil

    while lowest_idx <= highest_idx
      middle_idx = (lowest_idx + highest_idx) / 2
      number = nums[middle_idx]

      if number > target
        highest_idx = middle_idx - 1
      elsif number < target
        lowest_idx = middle_idx + 1
      else
        found_idx = middle_idx
        highest_idx = middle_idx - 1
      end
    end

    found_idx
  end
end
