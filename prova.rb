require 'csv'
require 'date'

# takes a date and data array
# returns a new array containing rows with matching year and month
def filter_by_month(date, records)
  filt_records = records.map{ |x| x if x[:data].month == date.month &&
    x[:data].year == date.year }.compact
end


data = Array.new

CSV.foreach('aaa.csv', col_sep: ';', headers: true) do |row|
    t = Hash.new
    t[:titolo] = row['Titolo']
    t[:data] = Date::strptime(row['Data'], "%d\/%m\/%Y")
    data << t
end

# filtro per nome titolo
#tim_array = data.map{ |x| x if x[:titolo] == 'tim' }
#puts tim_array.compact

dati_dicembre = filter_by_month(Date.new(2016,12,1), data)
puts dati_dicembre
