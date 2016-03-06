def check_win(game_board)
  #For each of the horizontal, vertical and diagonal functions
  def add_points(cell_to_consider, match_count, former_cell)
    #print cell_to_consider, match_count, former_cell
    #puts
    if cell_to_consider == '-'
      match_count = 0
    else
      if former_cell == cell_to_consider
        match_count += 1
      else
        match_count = 0
      end
      former_cell = cell_to_consider
    end
    return cell_to_consider, match_count, former_cell
  end

  def check_win_vertical(game_board)
    game_board.each do |column|  
      match_count = 0
      former_cell = 'none'
      column.split('').each do |cell_to_consider|  
        cell_to_consider, match_count, former_cell = add_points(cell_to_consider, match_count, former_cell)
        if match_count >= 3
          return true
        end
      end
    end
    return false
  end

  def check_win_horizontal(game_board)
    for i in 0..5
      match_count = 0
      former_cell = 'none'
      for j in 0..6
        cell_to_consider = game_board[j][i]
        cell_to_consider, match_count, former_cell = add_points(cell_to_consider, match_count, former_cell)
        if match_count >= 3
          return true
        end
      end
    end
    return false
  end

  def check_win_diagonal(game_board, i, upper_limit, side_stick, range)
    match_count = 0
    former_cell = 'none'
    range.each do |j|
      if i+j == upper_limit
        break
      end
      if side_stick == 'left'
        cell_to_consider = game_board[j][j+i]
      elsif side_stick == 'bottom_left'
        cell_to_consider = game_board[j+i][j]
      elsif side_stick == 'right'
        cell_to_consider = game_board[j][(6-j)+i]
      elsif side_stick == 'bottom_right'
        cell_to_consider = game_board[j-i][6-j]
      end
      cell_to_consider, match_count, former_cell = add_points(cell_to_consider, match_count, former_cell)
      if match_count >= 3
        return true
      end
    end
  end

  if check_win_horizontal(game_board) == true
    return true
  end

  if check_win_vertical(game_board) == true
    return true
  end  

  #These two check for wins, bl to tr
  for i in 0..2
    if check_win_diagonal(game_board, i, 6, 'left', (0..6).to_a) == true
      return true
    end
  end
  for i in 1..3
    if check_win_diagonal(game_board, i, 7, 'bottom_left', (0..6).to_a) == true
      return true
    end
  end

  #These two check for wins, br to tl
  for i in 0..2
    if check_win_diagonal(game_board, i, 0, 'right', (0..6).to_a.reverse) == true
      return true
    end
  end
  for i in 1..3
    if check_win_diagonal(game_board, i, 0, 'bottom_right', (0..6).to_a.reverse) == true
      return true
    end
  end

  return false
end