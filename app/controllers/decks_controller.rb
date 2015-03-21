class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def show
    @deck = find_deck
    @cards = @deck.cards
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.save
    redirect_to decks_path
  end

  def edit
    @deck = find_deck
  end

  def update
    @deck = find_deck
    @deck.update_attributes(deck_params)
    redirect_to @deck
  end

  def destroy
    Deck.delete(params[:id])
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end

  def find_deck
    Deck.find(params[:id])
  end
end
