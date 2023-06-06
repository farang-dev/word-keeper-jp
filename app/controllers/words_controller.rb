class WordsController < ApplicationController
  before_action :set_word, only: [:destroy]

  def index
    @words = current_user.words
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

  def fetch_word_description(word)
    response = URI.open("https://dictionaryapi.dev/api/v2/entries/en/#{word}")
    json = JSON.parse(response.read)
    json[0]['meanings'][0]['definitions'][0]['definition']
  rescue StandardError
    # Handle the case where the API request fails or no definition is found
    nil
  end


  def destroy
    if @word
      @word.destroy
      redirect_to words_path, notice: "Word was successfully deleted."
    else
      redirect_to words_path, alert: "Unable to find the specified word."
    end
  end

  private

  def word_params
    params.require(:word).permit(:title, :description)
  end

  def set_word
    @word = current_user.words.find_by(id: params[:id])
  end
end
