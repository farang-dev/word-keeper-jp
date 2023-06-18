class ReplaceReadingFromWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :temp_reading, :string

    Word.all.each do |word|
      word.update(temp_reading: word.reading)
    end

    remove_column :words, :reading, :string
    rename_column :words, :temp_reading, :reading
  end
end
