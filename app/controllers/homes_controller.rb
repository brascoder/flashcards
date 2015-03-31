class HomesController < ApplicationController
  def index
    redirect_to decks_path if signed_in?
  end
end
