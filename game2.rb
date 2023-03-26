require 'poker-eval'

class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end

class Deck
  def initialize
    @cards = []
    ['C', 'D', 'H', 'S'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'].each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end

class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
    @chips = 100
  end

  def add_card(card)
    @hand << card
  end

  def remove_card(card)
    @hand.delete(card)
  end

  def bet(amount)
    @chips -= amount
    amount
  end

  def receive_winnings(amount)
    @chips += amount
  end

  def chips
    @chips
  end
end

class Game
  attr_reader :players

  def initialize
    @deck = Deck.new
    @players = []
    @pot = 0
  end

  def add_player(player)
    @players << player
  end

  def deal_hole_cards
    @players.each do |player|
      2.times { player.add_card(@deck.deal_card) }
    end
  end

  def deal_flop
    3.times { @community_cards << @deck.deal_card }
  end

  def deal_turn
    @community_cards << @deck.deal_card
  end

  def deal_river
    @community_cards << @deck.deal_card
  end

  def bet_round(player)
    # ベットラウンドの実装
  end

  def showdown
    # ショーダウンの実装
  end
end
