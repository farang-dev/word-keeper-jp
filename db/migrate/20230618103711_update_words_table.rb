class UpdateWordsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :word_type, :string
    add_column :words, :translations, :text, default: [], array: true
    add_column :words, :example_sentences, :text, default: [], array: true
    add_column :words, :kanji_details, :text, default: [], array: true
  end
end
