require "minitest/autorun"
require "./draw_data.rb"

class DataTests < Minitest::Test

  def test_load_file_returns_array
    assert_instance_of Array, load_csv_file('./dati/test.csv')
  end

  def test_csv_array_length
    d = load_csv_file('./dati/test.csv')
    assert_equal 2, d.length
  end

end
