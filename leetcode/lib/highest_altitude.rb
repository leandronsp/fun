module HighestAltitude
  # Leetcode Problem #1732 - Find the Highest Altitude
  # There is a biker going on a road trip. The road trip consists of n + 1 points at different altitudes.
  # The biker starts his trip on point 0 with altitude equal 0.
  # 1. You are given an integer array gain of length n where gain[i] is the net gain in altitude between points i​​​​​​ and i + 1 for all (0 <= i < n).
  # 2. Return the highest altitude of a point.
  # Example 1:
  #  Input: gain = [-5,1,5,0,-7]
  #  Output: 1
  # Example 2:
  # Input: gain = [-4,-3,-2,-1,4,3,2]
  # Output: 0

  def highest_altitude(gain)
    acc = 0
    max = acc

    gain.reduce([0]) do |acc, num|
      altitude = acc.last + num
      max = altitude if altitude > max

      acc << altitude
    end

    max
  end
end
