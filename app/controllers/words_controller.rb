class WordsController < ApplicationController

  def index
    @words = current_user.words
    @word = Word.new
  end

  def new
    @word = Word.new
  end

  def create
    @word = current_user.words.new(word_params)
    if @word.save
      redirect_to words_path, notice: "Word was successfully created."
    else
      @words = current_user.words
      render :index
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_path
  end

  private

  def word_params
    params.require(:word).permit(:title, :description)
  end
end
