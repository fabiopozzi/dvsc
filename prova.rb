require 'csv'

CSV.foreach('aaa.csv', {:col_sep => ';', :headers => true}) do |row|
    puts row['Titolo']
end
