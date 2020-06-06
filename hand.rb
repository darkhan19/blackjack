# frozen_string_literal: true

module Hand
  attr_accessor :hand, :bank, :points

  def give_card(deck)
    @hand << deck.shift
    calculate_points
  end

  def make_bet
    @bank -= 10
  end

  def win_bet
    @bank += 20
  end

  def tie
    @bank += 10
  end

  def clean
    @hand = []
    @points = 0
  end

  def show_cards
    @hand.each do |card|
      print "|#{card.suit} #{card.face}|"
    end
    print "\n"
    show_points
  end

  def show_points
    puts "Твои очки: #{points}"
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
