class Game
 # < ActiveRecord::Base

  def winner?(board_string)
    board = transform_into_2d(board_string)
    winner = nil

    show(board)           { puts "Checking rows..." }
    winner ||= check_rows(board)

    show(rotate(board))   { puts "Checking columns..." }
    winner ||= check_rows(rotate(board))
    
    [tilt(board, -1), tilt(board, 1)].each do |board|
      show(rotate(board)) { puts "Checking diagonals..." }
      winner ||= check_rows(rotate(board))
    end
    
    puts "Winner: #{winner ? winner : 'nil' }"
    winner
  end

  private

  def transform_into_2d(board_string)
    board = []
    board_string.split("").each_slice(7) { |row| board << row}
    board.map! { |row| row.map(&:to_i) }
  end

  def check_rows(board) 
    winner = nil
    [1, 2].each do |p|
      board.each do |row|
        if row.each_cons(4).select {|row_fragment| row_fragment == [p,p,p,p]}.any?
          winner = p
        end
      end
    end
    winner
  end

  def rotate(board)
    rotated_board = []
    board[0].length.times { |i| rotated_board << board.map { |row| row[i] } }
    rotated_board
  end

  def tilt(board, direction)
    tilt_factor = (0..board.length - 1).to_a
    tilt_factor.reverse! if direction == 1
    board.map.with_index do |row, i|
      tilt = tilt_factor[i]
      [0] * tilt + row + [0] * (board.length - 1 - tilt)
    end
  end

  def show(board)
    yield
    board.each do |row|
      puts row.join('  ')
      puts
    end
    puts
  end
end


board_string = '000000000120000022210001122000121200211122'
Game.new.winner?(board_string)
__END__

0 0 0 0 0 0 0 
0 0 1 2 0 0 0 
0 0 2 2 2 1 0 
0 0 1 1 2 2 0 
0 0 1 2 1 2 0 
0 2 1 1 1 2 2 
