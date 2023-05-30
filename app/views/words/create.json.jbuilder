# app/views/words/create.json.jbuilder

if @word.persisted?
  json.inserted_item render(partial: "word", formats: :html, locals: { word: @word })
  json.form render(partial: "form", formats: :html, locals: { word: Word.new })
else
  json.form render(partial: "form", formats: :html, locals: { word: @word })
end
