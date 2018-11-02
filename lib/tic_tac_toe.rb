class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  def play
    turn_count = 0
    until turn_count == 9 || over? || draw?
      turn_count += 1
      turn
    end

    if draw?
      puts "Cat's Game!"
    else
      winning_player = winner
      puts "Congratulations #{winning_player}!"
    end

  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [6,4,2],
    [0,4,8]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    total = 0
    @board.each do |entry|
      if !(entry == "   " || entry == " ")
        total += 1
      end
    end
    total
  end

  def current_player
    player = turn_count % 2 == 0 ? "X" : "O"
    return player
  end

  def won?

    WIN_COMBINATIONS.each do |win_combo|
      pos_1 = @board[win_combo[0]]
      pos_2 = @board[win_combo[1]]
      pos_3 = @board[win_combo[2]]

      x_wins = pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      y_wins = pos_1 == "O" && pos_2 == "O" && pos_3 == "O"

      if x_wins || y_wins
        return win_combo
      else
        false
      end
    end

    return nil
  end

  def full?
    @board.none? {|i| i == "   " || i == " " || i == "" || i == nil}
  end

  def draw?
    !won? && full?
  end

  def over?
    #no need to call draw? method here- it would be redundant
    won? || full?
  end

  def winner
    if @board.empty?
      return nil
    end

    winning_combo = won?
      if winning_combo != nil
        return @board[winning_combo[0]]
      else
        return nil
      end
  end

end
