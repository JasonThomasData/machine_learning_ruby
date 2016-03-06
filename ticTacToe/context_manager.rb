class ContextManager
  #The data hash contains all the relationships based on where the initial and second markers are placed
  def initialize
    @context_hash = {
      'none' => {0=>0,1=>1,2=>2,3=>3,4=>4,5=>5,6=>6,7=>7,8=>8},
      '01' => {0=>0,1=>1,2=>2,3=>3,4=>4,5=>5,6=>6,7=>7,8=>8},    
      '25' => {0=>6,1=>3,2=>0,3=>7,4=>4,5=>1,6=>8,7=>5,8=>2},
      '78' => {0=>8,1=>7,2=>6,3=>5,4=>4,5=>3,6=>2,7=>1,8=>0},
      '36' => {0=>2,1=>5,2=>8,3=>1,4=>4,5=>7,6=>0,7=>3,8=>6}
    }
    @first_pass = true
    @first_key = 'none'
  end
  def pick_space(player_pick)
    if player_pick != '4'
      if @first_pass == true
        @first_key = @context_hash.keys.find {|k|
          k.include? player_pick
        }
        @first_pass = false
      end
    end
    return @context_hash[@first_key][player_pick.to_i]
  end
  #This function takes the recorded spaces and puts a marker on the board, setting the context for the game
  def get_random(player_pick)
    if '0268'.include? player_pick
      return ['0','2','6','8'].sample
    elsif '1357'.include? player_pick
      return ['1','3','5','7'].sample
    else 
      return player_pick
    end
  end
end

"
context = ContextManager.new
['4', '8', '6'].each do |space_picked| 
	puts 'space picked -'
	puts space_picked
	puts 'becomes - '
	puts context.pick_space(space_picked)
end
"