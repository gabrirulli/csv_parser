class Country
  def initialize(nation, city, altitude)
    @nation = nation
    @city = city
    @altitude = altitude
  end

  ### Check if there are nil values in csv file
  def nation
    @nation.nil? ? "" : @nation
  end

  def city
    @city.nil? ? "" : @city
  end

  def altitude
    @altitude.nil? ? 0 : @altitude.to_i
  end
end
