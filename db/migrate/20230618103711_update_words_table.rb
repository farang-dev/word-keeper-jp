class UpdateWordsTable < ActiveRecord::Migration[6.0]
  def up
    # Remove the columns
    remove_column :words, :word_type
    remove_column :words, :translations
    remove_column :words, :example_sentences
    remove_column :words, :kanji_details
    remove_column :words, :reading

    # Add the columns back with the desired data type
    add_column :words, :word_type, :string
    add_column :words, :translations, :text, default: [], array: true
    add_column :words, :example_sentences, :text, default: [], array: true
    add_column :words, :kanji_details, :text, default: [], array: true
    add_column :words, :reading, :string
  end

  def down
    # Revert the migration by removing the added columns
    remove_column :words, :word_type
    remove_column :words, :translations
    remove_column :words, :example_sentences
    remove_column :words, :kanji_details
    remove_column :words, :reading

    # Add the removed columns back with their previous data type
    add_column :words, :word_type, :string
    add_column :words, :translations, :string, default: [], array: true
    add_column :words, :example_sentences, :text, default: [], array: true
    add_column :words, :kanji_details, :text, default: [], array: true
    add_column :words, :reading, :string
  end
end
