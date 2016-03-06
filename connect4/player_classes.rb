class PlayerDumb
  def initialize(marker)
    @marker = marker
    new_object
  end
  def new_object
    #Each element will represent a turn, with two elements. The first is the game state, and the second is the move.
    @results = []
    @winner_status = nil
  end
  #Used to switch between board states for saving depending on the object's @marker
  def declare_winner()
    @winner_status = true
  end
  def declare_loser()
    @winner_status = false
  end
  def get_winner_status()
    return @winner_status
  end
  #Used to add to the json file of board states and frequencies
  def add_result(result)
    @results.push(result)
  end
  def get_result
    #print @result
    return @results
  end
  #Marker is 'x' or 'o'
  def get_marker
    return @marker
  end

  def pick_space(board_array, clean_AI)
    def return_space(board_array)
      spaces_list = []
      board_array.each_with_index do |item,index|
        if item.include? '-'
          spaces_list.push(index)
        end
      end
      i = spaces_list.sample
      return i
    end
    i = return_space(board_array)
    #print result, @marker
    #puts
    result = [board_array.join(''), i]
    @results.push(result)
    board_array[i].sub!('-', @marker)
    return board_array
  end
end

#what this class needs is for the original hash data to be passed into it.
#If the largest value in this hash data is more than twice the size of the next largest one, etc, then pick random
#Currently, I'm getting results that favour non-optimal choices from this class.
#If this is the only place cleanAI is used, get rid of it
#However, this may still be useful vs humans - brutal computer
class PlayerAI
  def initialize(marker)
    @marker = marker
    new_object
  end
  def new_object
    #Each element will represent a turn, with two elements. The first is the game state, and the second is the move.
    @results = []
    @winner_status = nil
  end
  #Used to switch between board states for saving depending on the object's @marker
  def declare_winner()
    @winner_status = true
  end
  def declare_loser()
    @winner_status = false
  end
  def get_winner_status()
    return @winner_status
  end
  #Used to add to the json file of board states and frequencies
  def add_result(result)
    @results.push(result)
  end
  def get_result
    #print @result
    return @results
  end
  #Marker is 'x' or 'o'
  def get_marker
    return @marker
  end

  def pick_space(board_array, clean_AI)
    key = board_array.join('')
    if clean_AI.has_key?(key)
      i = clean_AI[key]
    else
      spaces_list = []
      board_array.each_with_index do |item,index|
        if item.include? '-'
          spaces_list.push(index)
        end
      end
      i = spaces_list.sample
      puts 'No record exists, picking another'
    end
    result = [key, i]
    i = i.to_i
    #print result, @marker
    #puts result
    @results.push(result)
    board_array[i].sub!('-', @marker)
    #puts board_array.join('')
    return board_array
  end
end

class PlayerHuman
  def initialize(marker)
    @marker = marker
    new_object
  end
  def new_object
    #Each element will represent a turn, with two elements. The first is the game state, and the second is the move.
    @results = []
    @winner_status = nil
  end
  #Used to switch between board states for saving depending on the object's @marker
  def declare_winner()
    @winner_status = true
  end
  def declare_loser()
    @winner_status = false
  end
  def get_winner_status()
    return @winner_status
  end
  #Used to add to the json file of board states and frequencies
  def add_result(result)
    @results.push(result)
  end
  def get_result
    #print @result
    return @results
  end
  #Marker is 'x' or 'o'
  def get_marker
    return @marker
  end

  def pick_space(board_array, clean_AI)
    def print_board(board_array)
      print 'Choose column to drop marker'
      puts 
      for k in 0..6
      print  '   ', k, ' '
      end
      puts
      (0..5).to_a.reverse.each do |i|
      for j in 0..6
        print '   ', board_array[j][i], ' '
      end
      puts
      end
    end
    print_board(board_array)

    i = gets.chomp
    if '0123456'.include? i
      i = i.to_i
      if board_array[i].include? '-'
        result = [board_array.join(''), i]
        @results.push(result)
        board_array[i].sub!('-', @marker) #Should replace first only
        return board_array
      else
        puts "No spaces available there"
        pick_space(board_array, clean_AI)
      end
    else
      puts"Enter a number between 0 and 6"
      pick_space(board_array, clean_AI)
    end
  end
end
