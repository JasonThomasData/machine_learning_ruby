require 'json'
require './player_classes'
require './game_stuff'

#Use this to generate dataset
def play_dumb_bots()
    player_x = PlayerDumb.new 'x'
    player_o = PlayerDumb.new 'o'
    players = [player_x, player_o]
    show_messages = false
    data_file = "dumb_bots_data.json"
    start_time = Time.now    
    while true do
        File.open(data_file,"r+") do |json_file|
            data_hash = JSON.parse(json_file.read())
            init_data_table(data_hash)
            #Run the game 500 times then save the results to the file.
            for z in 1..50000 do
                a_single_game(players,data_hash,'', show_messages)
            end
            json_file.rewind
            json_file.write(data_hash.to_json)
            show_loop_results(data_hash, data_file, start_time)
        end
    end
end
play_dumb_bots()