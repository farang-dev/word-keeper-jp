class RemoveDuplicateReadingColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :words, :reading, if_exists: true
  end
end
