require 'sinatra'
require 'csv'
require 'date'
require 'chartkick'

# takes a date and data array
# returns a new array containing rows with matching year and month
def filter_by_month(date, records)
  records.select do |x|
    x[:data].month == date.month && x[:data].year == date.year
  end
end

data = []

CSV.foreach('./dati/aaa.csv', col_sep: ';', headers: true) do |row|
  t = {}
  t[:titolo] = row['Titolo']
  t[:data] = Date.strptime(row['Data'], "%d\/%m\/%Y")
  data << t
end

# filtro per nome titolo
# tim_array = data.map{ |x| x if x[:titolo] == 'tim' }
# puts tim_array.compact
dati_mese = []

(1..12).each do |i|
dati_mese << [i, filter_by_month(Date.new(2016, i, 1), data).count]
end

get '/' do
  @titolo = "Antani"
  erb :index, :locals => {:dati_mese => dati_mese}
end

