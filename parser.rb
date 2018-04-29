require 'csv'
require 'open-uri'
require_relative 'country'

class CsvParser
  def initialize
  end

  ### Open csv file from remote
  def csv
    open('https://raw.githubusercontent.com/Leevia/WorldCityLocations/master/World_Cities_Location_table.csv')
  end

  ### Every row of the csv creates a Country
  ### It returns array of countries
  def data
    data = []
    CSV.foreach(csv, quote_char: '"', col_sep: ';', row_sep: :auto) do |row|
      data << Country.new(row[1], row[2], row[5])
    end
    data
  end

  ### It groups by nation the array of countries and returns it
  def grouped_by_nation
    data.group_by do |country|
      country.nation
    end
  end

  ### It finds the highest city's altitude for each country
  def highests
    results = []
    grouped_by_nation.each do |k, v|
      highest = v.max_by{|d| d.altitude }
      results << highest
    end
    results.sort_by {|d| d.altitude}.reverse
  end

  ### It prints the results, sorted by altitude in descending order, in stdout and writes it in a file
  def return_results
    open('output.txt', 'a') { |f|
      highests.each do |result|
        f.puts "#{result.altitude}m - #{result.city}, #{result.nation}\n"
        puts "#{result.altitude}m - #{result.city}, #{result.nation}"
      end
    }
  end
end

countries = CsvParser.new.return_results
puts "Countries found: #{countries.count}"
