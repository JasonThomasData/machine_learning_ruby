def check_win(board_array, player, win_conditions)
    marker_locations = board_array.each_index.select{|i| board_array[i] == player.get_marker}
    if marker_locations.length >= 3
        win_conditions.each do |cond|
            #puts 
            #print player.get_marker
            #print cond
            #print marker_locations
            if (cond - marker_locations).empty?
                return true
            end
        end
    end
end

def init_data_table(data_hash)
    if data_hash.has_key?('stats') == false
        data_hash['stats'] = {}
        data_hash['stats']['5'] = 0
        data_hash['stats']['6'] = 0
        data_hash['stats']['7'] = 0
        data_hash['stats']['8'] = 0
        data_hash['stats']['9'] = 0
        data_hash['stats']['draw'] = 0
        data_hash['stats']['total'] = 0
    end
    if data_hash.has_key?('games_history') == false
        data_hash['games_history'] = {}
    end
end

def access_table(board_state, next_move, data_hash, win_result)
    next_move = next_move.to_s
    if data_hash['games_history'].has_key?(board_state) == false
        data_hash['games_history'][board_state] = {}
    end
    if win_result == true
        if data_hash['games_history'][board_state].has_key?(next_move) == false
            data_hash['games_history'][board_state][next_move] = 1
        else
            data_hash['games_history'][board_state][next_move] += 1
        end
    else
        if data_hash['games_history'][board_state].has_key?(next_move) == false
            data_hash['games_history'][board_state][next_move] = 0
        else
            data_hash['games_history'][board_state][next_move] -= 1
        end
    end
end

def save_results(players, data_hash)
    winner = ''
    loser = ''
    players.each { |player|
        if player.get_winner_status == true
            winner = player
        else 
            loser = player
        end
    }
    winner_results = winner.get_result
    loser_results = loser.get_result
    winner_results.each{ |result|
        #This block swaps all characters if the player is o. The data_hash stores all values as the player is x. An enemy is always stored as o, although the player may be o. So, the AI player in a human-AI match should be the x player to make it more simple.
        parse_state = result[0]
        parse_move = result[1]
        if winner.get_marker == 'o'
            parse_state.gsub!(/[x,o]/,'x' => 'o', 'o' => 'x')
        end
        access_table(parse_state, parse_move, data_hash, true)
    }
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
    #win_conditions = ['--x--x--x','-x--x--x-','x--x--x--','xxx------','---xxx---','------xxx','x---x---x','--x-x-x--']
    win_conditions = [[2,5,8],[1,4,7],[0,3,6],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]
    board_array = ['-','-','-','-','-','-','-','-','-']
    board_string = board_array.join('')
    players[0].new_object
    players[1].new_object
    j = [0,1].sample
    while board_string.include? '-'
        players[j].pick_space(board_array,clean_AI)
        #board_string becomes the key for this game state in the hash
        board_string = board_array.join('')
        if check_win(board_array, players[j], win_conditions) == true
            #puts players[j].get_marker + ' wins'
            moves = players[0].get_result.length + players[1].get_result.length
            moves = moves.to_s
            players[j].declare_winner
            if show_messages == true
                end_game_message('win', players[j])
            end
            #Saves the number of moves to get a win
            data_hash['stats'][moves] += 1
            save_results(players,data_hash)
            #One point for every game played.
            data_hash['stats']['total'] += 1
            break
        end
        unless board_string.include? '-'
            data_hash['stats']['total'] += 1
            data_hash['stats']['draw'] += 1
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