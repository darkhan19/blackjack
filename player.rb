# frozen_string_literal: true

class Player
  attr_reader :name
  include Hand

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
    @points = 0
  end
end
