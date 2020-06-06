# frozen_string_literal: true

class Card
  SUITS = %w[+ <3 ^ <>].freeze
  FACES = [*(2..10), 'Q', 'K', 'A'].freeze

  attr_reader :suit, :face, :value

  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end
end
