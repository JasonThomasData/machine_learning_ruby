####play_dumb_bots.rb
This spins up two objects that just generate random boards, and there's a seperate function that looks for win conditions.
When an object gets a win condition, the program loops back through the winning object's board states and next moves, giving each move another point.
If an object gets a loss, then each move for the previous state loses a point.

####play_against_computer.rb
The program cleans up the results of the random games, finding the best next move for each board state.

If you're wondering why I've used separate FILE.open methods for reading and writing to the data file, it is because the file shrinks at times, and truncating the data will leave legacy characters at the end.

####Issues
The other folder in this repo is TicTacToe.
Connect 4 has been simpler to program than TicTacToe, because the board is hardly ever symetrical.

If you start on a corner square in TicTacToe, that's the same pattern as starting on any corner square, and moves must be reduced to that context if the program is to recognise those patterns.
In Connect 4, drop a marker into any place on the board (other than the middle column) and the board is no longer symetrical.
Therefore there is no context to manage.

The game takes a long time, partially because it accesses a json file.
It is also checking wins programatically, unlike the pre-defined list of wins in the TicTacToe game.

I have removed the dumb_bots_data.json file, since it is approaching 100 mb after not long at all.
