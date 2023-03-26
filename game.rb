require 'poker-eval'

# ポーカーのルールに従った役名を返す
def hand_name(hand)
  eval = PokerEval::HandEvaluator.new
  score = eval.evaluate_hand(hand)
  PokerEval::HandEvaluator::STANDARD_RANKINGS[score]
end

# ゲームのルールを設定
NUM_PLAYERS = 4
NUM_CARDS = 2
MAX_BET = 100
SMALL_BLIND = 10
BIG_BLIND = 20

# カードとデッキを作成する
class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    %w(H D C S).each do |suit|
      %w(2 3 4 5 6 7 8 9 T J Q K A).each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end

  def deal(num_cards)
    @cards.shift(num_cards)
  end
end

# プレイヤーを作成する
class Player
  attr_accessor :name, :chips, :hand

  def initialize(name, chips)
    @name = name
    @chips = chips
    @hand = []
  end

  def to_s
    "#{@name} has #{@chips} chips"
  end
end

# ゲームの進行を管理する
class Game
  attr_accessor :deck, :players, :community_cards, :pot, :current_bet, :last_bet

  def initialize(num_players, num_cards, max_bet, small_blind, big_blind)
    @deck = Deck.new
    @players = []
    num_players.times do |i|
      @players << Player.new("Player #{i+1}", 1000)
    end
    @community_cards = []
    @pot = 0
    @current_bet = 0
    @last_bet = 0
    @max_bet = max_bet
    @small_blind = small_blind
    @big_blind = big_blind
  end

  def play
    # プリフロップ
    puts "Pre-flop"
    @players.each do |player|
      player.hand = @deck.deal(NUM_CARDS)
      puts "#{player.name} has #{player.hand[0]} #{player.hand[1]}"
    end
    betting_round

    # フロップ
    puts "Flop"
    @community_cards += @deck.deal(3)
    puts "Community cards: #{@community_cards[0]} #{@community_cards[1]} #{@community_cards[2]}"
    betting_round

    # ターン
    puts "Turn"
  end
end
