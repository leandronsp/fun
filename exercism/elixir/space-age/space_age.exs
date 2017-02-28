defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.

  1 day = (24 * 60 * 60) seconds
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(:earth, seconds),   do: seconds / (365.25 * 24 * 60 * 60)
  def age_on(:mercury, seconds), do: age_on(:earth, seconds) / 0.2408467
  def age_on(:venus, seconds),   do: age_on(:earth, seconds) / 0.61519726
  def age_on(:mars, seconds),    do: age_on(:earth, seconds) / 1.8808158
  def age_on(:jupiter, seconds), do: age_on(:earth, seconds) / 11.862615
  def age_on(:saturn, seconds),  do: age_on(:earth, seconds) / 29.447498
  def age_on(:uranus, seconds),  do: age_on(:earth, seconds) / 84.016846
  def age_on(:neptune, seconds), do: age_on(:earth, seconds) / 164.79132
end
