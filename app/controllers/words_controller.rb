require 'open-uri'

class WordsController < ApplicationController
  def index
    @words = Word.order(created_at: :desc)
    @word = Word.new
  end

  def create
    word_title = params[:word][:title]
    description = fetch_word_description(word_title)

    @word = Word.new(title: word_title, description: description)
    @word.user = current_user

    respond_to do |format|
      if @word.save
        format.html { redirect_to words_path, notice: "Word was successfully created." }
        format.json { render :create, status: :created, location: @word }
      else
        format.html { render :index }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_path
  end

  def fetch_word_description(word)
    response = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
    json = JSON.parse(response.read)
    definition = json[0]['meanings'][0]['definitions'][0]['definition']
    return definition if definition.present?

    # Handle the case where no definition is found
    'No definition available'
  rescue OpenURI::HTTPError => e
    case e.io.status[0]
    when "404"
      'Unable to fetch definition: Word not found'
    when "500"
      'Unable to fetch definition: Internal server error'
    else
      'Unable to fetch definition: HTTP Error'
    end
  end
end
