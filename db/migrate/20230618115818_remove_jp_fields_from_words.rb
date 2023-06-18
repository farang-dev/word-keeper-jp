class RemoveJpFieldsFromWords < ActiveRecord::Migration[7.0]
  def change
    remove_column :words, :jptitle, :string
    remove_column :words, :jpdescription, :text
  end
end
