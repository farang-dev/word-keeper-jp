class AddTitleAndDescriptionToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :title, :string
    add_column :words, :description, :text
  end
end
