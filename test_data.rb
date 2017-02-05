require "minitest/autorun"
require "./draw_data.rb"

class DataTests < Minitest::Test
  def test_load_file_returns_some_data
    assert_instance_of Array, load_csv_file('./dati/test.csv')
  end
end
