require 'sinatra'
require 'csv'
require 'date'
require 'chartkick'

def load_csv_file filename
  data = []
  CSV.foreach(filename, col_sep: ';', headers: true) do |row|
    t = {}
    t[:titolo] = row['Titolo']
    t[:data] = Date.strptime(row['Data'], "%d\/%m\/%Y")
    t[:categoria] = row['Categoria principale']
    t[:importo] = row['Importo']
    data << t
  end
  data
end

# takes a date and data array
# returns a new array containing rows with matching year and month
def filter_by_month(date, records)
  records.select do |x|
    x[:data].month == date.month && x[:data].year == date.year
  end
end

def totale_hobby_per_mese records
  entries = []
  (1..12).each do |i|
    d = filter_by_month(Date.new(2016, i, 1), records)
    hobby = d.select { |x| x[:categoria] == "Sport e tempo libero" }
    entries << [i, totale_per_mese(hobby)]
  end
  entries
end

def totale_per_mese dati_mese
    tot = dati_mese.inject(0) {|sum, x| sum + x[:importo].to_i.abs}
end

def numero_entry_per_mese records
  dati_mese = []

  (1..12).each do |i|
    cur_month = Date.new(2016, i, 1)
    dati_mese << [i, filter_by_month(cur_month, records).count]
  end
  dati_mese
end

dati_grezzi = load_csv_file('./dati/aaa.csv')
dati_mese = numero_entry_per_mese(dati_grezzi)

tot_hobby = totale_hobby_per_mese(dati_grezzi)
#puts dati_mese.inspect
#puts tot_hobby.inspect

get '/' do
  @titolo1 = "Numero spese"
  @titolo2 = "Totale spese 'hobby'"
  erb :index, :locals => {:dati_mese => dati_mese, :dati_hobby => tot_hobby}
end

