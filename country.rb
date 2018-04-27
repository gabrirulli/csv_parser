class Country
  def initialize(nation, city, altitude)
    @nation = nation
    @city = city
    @altitude = altitude
  end

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
