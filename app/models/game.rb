class Game < ActiveRecord::Base

  def winner?(board_string)
    board = transform_into_2d(board_string)
    winner = nil

    winner ||= check_rows(board)
    [board, transform(board, -1), transform(board, 1)].each do |board|
      winner ||= check_columns(board)
    end
    return winner
  end

  private

  def transform_into_2d(board_string)
    # board string is a string of 0, 1 or 2
    # returns 2d array
  end

  def check_rows(board)
    # board is a 2d array of 0, 1, or 2
    # returns nil or winner number (1 or 2)
  end

  def check_columns(board)
    # board is a 2d array of 0, 1, or 2
    # returns nil or winner number (1 or 2)
  end

  def transform(board, direction)
    # board is a 2d array of 0, 1, or 2
    # direction is -1 or 1 (indicating left or right)
    # returns 2d array that is compatible with check_columns.
    # it'll probably have to fill in lots of zeros.
  end
end

__END__

figure when a player has won
we'll need all the cells in the database
they'll probably associated into locations from 0-41 based on div data- attribute
we need to be able to do board transform_left and transform right
we need to check columns, rows for sets of 4
We need to return nil or winning username


the DOM will have class of player1, player2


0 = empty div
1 = div of class player 1
2 = div of class player 2

we'll be sent string, read directly from the DOM, in JS.
We'll parse string into 2d array.


0 0 0 0 0 0 0 
0 0 1 2 0 0 0 
0 0 2 2 2 1 0 
0 0 1 1 2 2 0 
0 0 1 2 1 2 0 
0 2 1 1 1 2 1 
