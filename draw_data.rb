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

def totale_hobby_per_mese records
  (1..12).each do |i|
    d = filter_by_month(Date.new(2016, i, 1), records)
    hobby = d.select { |x| x[:categoria] == "Sport e tempo libero" }
    puts hobby.inspect
  end
end

def numero_entry_per_mese records
  dati_mese = []

  (1..12).each do |i|
    dati_mese << [i, filter_by_month(Date.new(2016, i, 1), records).count]
  end
  dati_mese
end

def load_csv_file filename
  data = []
  CSV.foreach(filename, col_sep: ';', headers: true) do |row|
    t = {}
    t[:titolo] = row['Titolo']
    t[:data] = Date.strptime(row['Data'], "%d\/%m\/%Y")
    t[:categoria] = row['Categoria principale']
    data << t
  end
  data
end

dati_grezzi = load_csv_file('./dati/aaa.csv')
# filtro per nome titolo
# tim_array = data.map{ |x| x if x[:titolo] == 'tim' }
# puts tim_array.compact
dati_mese = numero_entry_per_mese dati_grezzi

totale_hobby_per_mese dati_grezzi

get '/' do
  @titolo1 = "Numero entry per mese"
  erb :index, :locals => {:dati_mese => dati_mese}
end

