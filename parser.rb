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
  ### It prints the output in stdout and writes it in a file
  def highests
    open('output.txt', 'a') { |f|
      grouped_by_nation.each do |k, v|
        highest = v.max_by{|d| d.altitude }
        f.puts "#{highest.altitude}m - #{highest.city}, #{highest.nation}\n"
        puts "#{highest.altitude}m - #{highest.city}, #{highest.nation}"
      end
    }
  end
end

countries = CsvParser.new.highests
puts "Countries found: #{countries.count}"
