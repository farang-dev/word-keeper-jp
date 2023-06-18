# db/migrate/20230618100000_add_columns_to_words.rb

class AddColumnsToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :reading, :string
  end
end
