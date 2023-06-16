class PagesController < ApplicationController
  def home
    # Controller code here
    if user_signed_in?
      redirect_to words_path
    end
  end
end
