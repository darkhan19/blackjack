# frozen_string_literal: true

class Game
  def intro
    @dealer = Dealer.new
    @player = Player.new(Interface.ask_for_name)
    Interface.show_intro(@player, @dealer)
    new_turn
  end

  def round
    @player.make_bet
    @dealer.make_bet
    give_cards(2, @player, @deck)
    give_cards(2, @dealer, @deck)
    Interface.show_bank(@player, @dealer)
    Interface.show_player_cards_points(@player)
    player_move
  end

  def new_turn
    Interface.game_over if @dealer.bank.zero? || @player.bank.zero?
    @deck = Deck.new.generate_deck
    @player.clean
    @dealer.clean
    round
  end

  def player_move
    choice = Interface.ask_for_move
    case choice
    when :take_card
      if @player.hand.size > 2
        puts '3 Карты максимум!'
        open_cards
      else
        give_cards(1, @player, @deck)
        @dealer.turn(@deck)
        Interface.show_player_cards_points(@player)
        player_move
      end
    when :pass
      dealer_turn(@dealer, @deck)
      player_move
    when :open
      open_cards
    end
  end

  def open_cards
    Interface.round_result(winner_name, find_winner, @player, @dealer)
    Interface.show_bank(@player, @dealer)
    Interface.show_dealer_cards_points(@dealer)
    Interface.show_player_cards_points(@player)
    play_again
  end

  def play_again
    choice = Interface.ask_for_play_again
    case choice
    when :one_more
      new_turn
    end
  end

  def find_winner
    return @player if @dealer.points > 21
    return @dealer if @player.points > 21

    if @player.points == @dealer.points
      false
    elsif @player.points > @dealer.points
      @player
    else
      @dealer
    end
  end

  def winner_name
    if find_winner == false
      'Ничья'
    else
      find_winner.name
    end
  end

  def give_cards(count, player, deck)
    count.times { player.give_card(deck) }
  end

  def dealer_turn(dealer, deck)
    if dealer.points > 17 || dealer.hand.size == 3
      puts "\n"
      puts 'Дилер пропустил ход'
      puts "\n"
    else
      give_cards(1, dealer, deck)
    end
  end
end
