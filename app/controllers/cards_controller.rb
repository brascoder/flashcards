class CardsController < ApplicationController
  def show
    @deck = find_deck
    @card = find_card(@deck)
  end

  def new
    @deck = find_deck
    @card = @deck.cards.new
  end

  def create
    @deck = find_deck
    @card = @deck.cards.new(card_params)
    @card.save
    redirect_to @deck
  end

  def edit
    @deck = find_deck
    @card = find_card(@deck)
  end

  def update
    @deck = find_deck
    @card = find_card(@deck)
    @card.update_attributes(card_params)
    redirect_to @deck
  end

  def destroy
    @deck = find_deck
    @card = find_card(@deck)
    Card.delete(params[:id])
    redirect_to @deck
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end

  def find_deck
    Deck.find(params[:deck_id])
  end

  def find_card deck
    deck.cards.find(params[:id])
  end
end
