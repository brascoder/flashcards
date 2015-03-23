class DecksController < ApplicationController
  before_action :authenticate

  def index
    @decks = current_user.decks
  end

  def show
    @deck = find_deck
    @cards = @deck.cards
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
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
    current_user.decks.delete(params[:id])
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end

  def find_deck
    current_user.decks.find(params[:id])
  end

  end
