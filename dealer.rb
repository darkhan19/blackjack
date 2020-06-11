# frozen_string_literal: true

class Dealer
  include Hand
  attr_reader :name, :points
  def initialize
    @name = "Дилер №#{rand(1..100)}"
    @bank = 100
    @hand = []
    @points = 0
  end
end
