class PlayerDumb
    def initialize(marker)
        @marker = marker
        new_object
    end
    def new_object
        #Each element will represent a turn, with two elements. The first is the game state, and the second is the move.
        @results = []
        @winner = false
    end
    #Used to switch between board states for saving depending on the object's @marker
    def declare_winner()
        @winner = true
    end
    def get_winner_status()
        return @winner
    end
    #Used to add to the json file of board states and frequencies
    def add_result(result)
        @results.push(result)
    end
    def get_result
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
                if item == '-'
                    spaces_list.push(index)
                end
            end
            i = spaces_list.sample
            return i
        end
        i = return_space(board_array)
        result = [board_array.join(''), i]
        #print result, @marker
        #puts
        @results.push(result)
        board_array[i] = @marker
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
        @winner = false
    end
    #Used to switch between board states for saving depending on the object's @marker
    def declare_winner()
        @winner = true
    end
    def get_winner_status()
        return @winner
    end
    #Used to add to the json file of board states and frequencies
    def add_result(result)
        @results.push(result)
    end
    def get_result
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
                if item == '-'
                    spaces_list.push(index)
                end
            end
            i = spaces_list.sample
            #'No record exists, picking another'
        end
        result = [key, i]
        i = i.to_i
        #print result, @marker
        #puts result
        @results.push(result)
        board_array[i] = @marker
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
        @winner = false
    end
    #Used to switch between board states for saving depending on the object's @marker
    def declare_winner()
        @winner = true
    end
    def get_winner_status()
        return @winner
    end
    #Used to add to the json file of board states and frequencies
    def add_result(result)
        @results.push(result)
    end
    def get_result
        return @results
    end
    #Marker is 'x' or 'o'
    def get_marker
        return @marker
    end

    def pick_space(board_array, clean_AI)
        show_board = board_array.join('')
        puts "This is the board: \n  " + show_board[0..2] + "\n  " + show_board[3..5] + "\n  " + show_board[6..8]

        puts "Choose a space, in this arrangement: \n  012\n  345\n  678"
        i = gets.chomp
        if '012345678'.include? i
            i = i.to_i
            if board_array[i] == '-'
                result = [board_array.join(''), i]
                @results.push(result)
                board_array[i] = @marker
                return board_array
            else
                puts"That space is already taken"
                pick_space(board_array, clean_AI)
            end
        else
            puts"Enter a number between 0 and 8"
            pick_space(board_array, clean_AI)
        end
    end
end
