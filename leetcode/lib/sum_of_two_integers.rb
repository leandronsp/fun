module SumOfTwoIntegers
  # LeetCode 371. Sum of Two Integers
  #
  # Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -.
  # Example:
  # Given a = 1 and b = 2, return 3.
  #
  # Bitwise AND: a & b
  # Bitwise XOR: a ^ b
  # Bitwise Left Shift: a << b
  # Bitwise NOT: ~a
  #
  # 1. XORing a and b will give you the sum of a and b without carrying.
  # 2. ANDing a and b will give you the carry, if any.
  # 3. Left shifting the carry will give you the value of the carry for the next addition.
  # 4. Add the sum (without carry) and the carry (shifted) to get the final sum.
  # 5. Repeat until there is no carry (i.e., carry == 0).
  # 6. To handle negative integers, you can cap the XOR sum using a mask of 0xFFFFFFFF. The mask 0xFFFFFFFF is used because Ruby uses arbitrary size integers, and we only want to use the lower 32 bits.
  # 7. To handle negative integers, you can cap the sum using a mask of 0x80000000, which is the max positive integer. The mask 0x80000000 is used because Ruby uses arbitrary size integers, and we only want to use the lower 32 bits. We then apply two's complement to the sum to get the final sum.

  def get_sum(a, b)
    return a if b.zero?

    get_sum(
      mask_32_bitsum(a, b),
      carry(a, b)
    )
  end

  def mask_32_bitsum(a, b, mask = 0xFFFFFFFF, max_positive = 0x80000000)
    sum = (a ^ b) & mask
    sum & max_positive == 0 ? sum : ~(sum ^ mask)
  end

  def carry(a, b) = (a & b) << 1
end
