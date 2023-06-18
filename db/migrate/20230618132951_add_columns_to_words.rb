class AddColumnsToWords < ActiveRecord::Migration[7.0]
  def change
    remove_column :words, :reading, :string, if_exists: true
    remove_column :words, :word_type, :string, if_exists: true
    remove_column :words, :translations, :text, default: [], array: true, if_exists: true
    remove_column :words, :example_sentences, :text, default: [], array: true, if_exists: true
    remove_column :words, :kanji_details, :text, default: [], array: true, if_exists: true

    add_column :words, :reading, :string
    add_column :words, :word_type, :string
    add_column :words, :translations, :text, default: [], array: true
    add_column :words, :example_sentences, :text, default: [], array: true
    add_column :words, :kanji_details, :text, default: [], array: true
  end
end
