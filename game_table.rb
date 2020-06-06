class GameTable 
  
  def intro 
    puts 'Привет давай сыграем'
    puts 'Как тебя зовут?'
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new
    puts "Приветсвую тебя #{@player.name}, против тебя играет робот #{@dealer.name}"
    new_turn
  end

  def round
    @player.make_bet
    @dealer.make_bet
    give_cards(2, @player, @deck)
    give_cards(2, @dealer, @deck)
    show_bank
    show_player_cards_points
    player_move
  end

  def new_turn
    puts 'У кого-то из вас закончились деньги!' if @dealer.bank.zero? || @player.bank.zero?
    @deck = Deck.new.generate_deck
    @player.clean
    @dealer.clean
    round
  end  

  def player_move
    puts 'Выбери что хочешь сделать?
          1. Взять карту
          2. Пропустить ход
          3. Открыть карты'
    choice = gets.chomp
    case choice
    when '1' 
      if @player.hand.size > 2 
        puts '3 Карты максимум!' 
        open_cards
      else
        give_cards(1, @player, @deck)
        @dealer.turn(@deck)
        show_player_cards_points
        player_move
      end
    when '2'
      @dealer.turn(@deck)
      player_move
    when '3'
      open_cards
    end 
  end

  def open_cards
    round_result
    show_bank
    show_dealer_cards_points
    show_player_cards_points
    play_again
  end

  def play_again
    puts 'Хочешь сыгарть еще?
          1. да
          2. нет'
    choice = gets.chomp
    case choice
    when '1'
      new_turn
    when '2'
      exit
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

  def round_result
    winner = find_winner
    if winner == false
      @player.tie
      @dealer.tie
    else 
      winner.win_bet
    end
    print "\n"
    print "\n"
    puts "Итоги победитель/ничья: #{winner_name}"
  end

  def show_dealer_cards_points
    print "Карты дилера: "
    @dealer.hand.each { |card| print "|#{card.suit} #{card.face}|" }
    print "\n"
    print "Очки дилера: #{@dealer.points}"
    print "\n"
  end

  def show_player_cards_points
    print "Твои карты: "
    @player.hand.each { |card| print "|#{card.suit} #{card.face}|" }
    print "\n"
    print "Твои очки: #{@player.points}"
    print "\n"
  end
  
  def show_bank
    puts "Твой баланс: #{@player.bank}$"
    puts "Крупье баланс: #{@dealer.bank}$"
  end

  def give_cards(count, player, deck)
    count.times { player.give_card(deck)}    
  end
end
