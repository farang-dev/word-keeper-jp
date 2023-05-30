class WordsController < ApplicationController
  before_action :set_word, only: [:destroy]

  def index
    @words = current_user.words
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
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
