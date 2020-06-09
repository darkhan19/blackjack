# frozen_string_literal: true

module Hand
  attr_accessor :hand, :bank, :points

  BET = 10

  def give_card(deck)
    @hand << deck.shift
    calculate_points
  end

  def make_bet
    @bank -= BET
  end

  def win_bet
    @bank += 2 * BET
  end

  def tie
    @bank += BET
  end

  def clean
    @hand = []
    @points = 0
  end

  private

  def calculate_points
    @points = 0
    @hand.each do |card|
      @points += if card.face == 'A' && @points + 11 > 21
                   1
                 else
                   card.value
                 end
    end
  end
end
