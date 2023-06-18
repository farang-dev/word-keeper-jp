class AddReadingToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :reading, :string
  end
end
