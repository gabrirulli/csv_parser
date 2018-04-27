require 'csv'
require 'open-uri'
require_relative 'country'

class CsvParser
  def initialize
  end

  def csv
    open('https://raw.githubusercontent.com/Leevia/WorldCityLocations/master/World_Cities_Location_table.csv')
  end

  def data
    data = []
    CSV.foreach(csv, quote_char: '"', col_sep: ';', row_sep: :auto) do |row|
      data << Country.new(row[1], row[2], row[5])
    end
    data
  end

  def grouped_by_nation
    data.group_by do |country|
      country.nation
    end
  end

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
