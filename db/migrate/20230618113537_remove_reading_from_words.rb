class RemoveReadingFromWords < ActiveRecord::Migration[7.0]
  def change
    remove_column :words, :reading, :string
  end
end
