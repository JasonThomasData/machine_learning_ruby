require 'json'
require './player_classes'
require './game_stuff'

def play_against_computer()
    player_x = PlayerAI.new 'x'
    player_o = PlayerHuman.new 'o'
    players = [player_x, player_o]
    show_messages = true
    data_file = "dumb_bots_data.json"
    File.open(data_file,"r+") do |json_file|
        data_hash = JSON.parse(json_file.read())
        init_data_table(data_hash)
        #Go through results, clean up AI.
        clean_AI = get_clean_AI(data_hash)
        a_single_game(players,data_hash,clean_AI, show_messages)
        json_file.rewind
        json_file.write(data_hash.to_json)
        #show_loop_results(data_hash, data_file)
    end
end
play_against_computer()