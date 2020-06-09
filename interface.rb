# frozen_string_literal: true

module Interface
  module_function

  def ask_for_name
    puts 'Привет давай сыграем'
    puts 'Как тебя зовут?'
    gets.chomp
  end

  def show_intro(player, dealer)
    puts "Приветсвую тебя #{player.name}, против тебя играет робот #{dealer.name}"
  end

  def show_bank(player, dealer)
    puts "Твой баланс: #{player.bank}$"
    puts "Крупье баланс: #{dealer.bank}$"
  end

  def show_player_cards_points(player)
    print 'Твои карты: '
    player.hand.each { |card| print "|#{card.suit} #{card.face}|" }
    print "\n"
    print "Твои очки: #{player.points}"
    print "\n"
  end

  def show_dealer_cards_points(dealer)
    print 'Карты дилера: '
    dealer.hand.each { |card| print "|#{card.suit} #{card.face}|" }
    print "\n"
    print "Очки дилера: #{dealer.points}"
    print "\n"
  end

  def ask_for_move
    puts 'Выбери что хочешь сделать?
          1. Взять карту
          2. Пропустить ход
          3. Открыть карты'
    des = gets.chomp
    if des == '1'
      :take_card
    elsif des == '2'
      :pass
    else
      :open
    end
  end

  def ask_for_play_again
    puts 'Хочешь сыгарть еще?
    1. да
    2. нет'
    choice = gets.chomp
    return :one_more if choice == '1'

    exit
  end

  def round_result(name, winner, dealer, player)
    winner_name = name
    if winner_name == false
      player.tie
      dealer.tie
    else
      winner.win_bet
    end
    print "\n"
    print "\n"
    puts "Итоги победитель/ничья: #{winner_name}"
  end

  def show_cards(player)
    player.hand.each do |card|
      print "|#{card.suit} #{card.face}|"
    end
    print "\n"
    show_points(player)
  end

  def show_points(player)
    puts "#{player.name} очки: #{player.points}"
  end

  def game_over
    puts 'У кого-то из вас закончились деньги!'
  end
end
