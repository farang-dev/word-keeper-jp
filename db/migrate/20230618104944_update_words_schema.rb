class UpdateWordsSchema < ActiveRecord::Migration[6.0]
  def change
    remove_column :words, :title, :string
    remove_column :words, :description, :text

    add_column :words, :jptitle, :string
    add_column :words, :jpdescription, :text
  end
end
