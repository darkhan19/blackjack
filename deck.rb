# frozen_string_literal: true

class Deck
  attr_accessor :deck
  def generate_deck
    @deck = []
    Card::FACES.each do |face|
      value = if face.class == Integer
                face
              elsif face == 'A'
                11
              else
                10
              end
      Card::SUITS.each do |suit|
        @deck << Card.new(suit, face, value)
      end
    end
    @deck.shuffle!
  end
end
