require './check_win_conditions'

def init_data_table(data_hash)
  if data_hash.has_key?('stats') == false
    data_hash['stats'] = {}
    for i in 7..42
      data_hash['stats'][i.to_s] = 0
    end
    data_hash['stats']['draw'] = 0
    data_hash['stats']['total'] = 0
  end
  if data_hash.has_key?('games_history') == false
    data_hash['games_history'] = {}
  end
end

def access_table(board_state, next_move, data_hash, win_result)
  #puts win_result
  #puts board_state
  #puts next_move
  next_move = next_move.to_s
  if data_hash['games_history'].has_key?(board_state) == false
    data_hash['games_history'][board_state] = {}
  end
  if win_result == true
    if data_hash['games_history'][board_state].has_key?(next_move) == false
      data_hash['games_history'][board_state][next_move] = 0
    else
      data_hash['games_history'][board_state][next_move] += 1
    end
  elsif win_result == false    
    if data_hash['games_history'][board_state].has_key?(next_move) == false
      data_hash['games_history'][board_state][next_move] = 0
    else    
      data_hash['games_history'][board_state][next_move] -= 1
    end
  else
    if data_hash['games_history'][board_state].has_key?(next_move) == false
      data_hash['games_history'][board_state][next_move] = 0
    end
  end
end

def save_results(players, data_hash)
  def save_drawer(drawer, data_hash)
    drawer_results = drawer.get_result
    drawer_results.each{ |result|
      #This block swaps all characters if the player is o. The data_hash stores all values as the player is x. An enemy is always stored as o, although the player may be o. So, the AI player in a human-AI match should be the x player to make it more simple.
      parse_state = result[0]
      parse_move = result[1]
      if drawer.get_marker == 'o' 
        parse_state.gsub!(/[x,o]/,'x' => 'o', 'o' => 'x')
      end
      access_table(parse_state, parse_move, data_hash, nil)
    }
  end  
  def save_winner(winner, data_hash)
    winner_results = winner.get_result
    winner_results.each{ |result|
      #This block swaps all characters if the player is o. The data_hash stores all values as the player is x. An enemy is always stored as o, although the player may be o. So, the AI player in a human-AI match should be the x player to make it more simple.
      parse_state = result[0]
      parse_move = result[1]
      if winner.get_marker == 'o'
        parse_state.gsub!(/[x,o]/,'x' => 'o', 'o' => 'x')
      end
      access_table(parse_state, parse_move, data_hash, true)
    }
  end
  def save_loser(loser, data_hash)
    loser_results = loser.get_result
    loser_results.each { |result|
      #This block swaps all characters if the player is o. The data_hash stores all values as the player is x. An enemy is always stored as o, although the player may be o. So, the AI player in a human-AI match should be the x player to make it more simple.
      parse_state = result[0]
      parse_move = result[1]
      if loser.get_marker == 'o' 
        parse_state.gsub!(/[x,o]/,'x' => 'o', 'o' => 'x')
      end
      access_table(parse_state, parse_move, data_hash, false)
    }
  end
  players.each { |player|
    #puts player.get_winner_status
    if player.get_winner_status == true
      save_winner(player, data_hash)
    elsif player.get_winner_status == false
      save_loser(player, data_hash)
    else
      save_drawer(player, data_hash)
    end
  }  
end

def show_loop_results(data_hash, data_file, start_time)
  #output - game number, file size(bytes), length of results
  time_diff = Time.now.to_i - start_time.to_i
  print time_diff
  print ', '
  print data_hash['stats']['total']
  print ', '
  print File.size(data_file)
  print ', '
  puts data_hash['games_history'].length
end

def end_game_message(game_result, player)
  if game_result == 'win'
    print 'Player ', player.get_marker, ' wins'
    puts
  elsif game_result == 'draw'
    puts 'Game is a draw'
  end
end

def a_single_game(players,data_hash,clean_AI, show_messages)
  board_array = ['------','------','------','------','------','------','------']
  board_string = board_array.join('')
  players[0].new_object
  players[1].new_object
  j = [0,1].sample
  while board_string.include? '-'
    players[j].pick_space(board_array,clean_AI)
    #board_string becomes the key for this game state in the hash
    board_string = board_array.join('')
    if check_win(board_array) == true
      #puts players[j].get_marker + ' wins'
      moves = players[0].get_result.length + players[1].get_result.length
      moves = moves.to_s
      if j == 0
        players[0].declare_winner
        players[1].declare_loser
      else
        players[1].declare_winner
        players[0].declare_loser
      end
      if show_messages == true
        end_game_message('win', players[j])
      end
      #Saves the number of moves to get a win
      data_hash['stats'][moves] += 1
      #One point for every game played.
      data_hash['stats']['total'] += 1
      save_results(players,data_hash)
      break
    end
    unless board_string.include? '-'
      data_hash['stats']['total'] += 1
      data_hash['stats']['draw'] += 1
      save_results(players,data_hash)
      if show_messages == true
        end_game_message('draw', '')
      end
      break
    end
    #Alternates between players[j]
    if j == 0
      j = 1
    else
      j = 0
    end
  end
end

def get_clean_AI(data_hash)
  #returns a hash table with each board state and most favourable next move
  clean_AI = {}
  if data_hash.length > 1
    data_hash['games_history'].each{ |keyOuter, data|
      data.each{ |keyInner, value| 
        if value == data.values.max
          clean_AI[keyOuter] = keyInner
        end
      }
    }
  end  
  return clean_AI
end