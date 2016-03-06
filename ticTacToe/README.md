####play_dumb_bots.rb
This spins up two objects that just generate random boards, and there's a seperate function that looks for win conditions.
When an object gets a win condition, the program loops back through the winning object's board states and next moves, giving each move another point.
If an object gets a loss, then each move for the previous state loses a point.

####play_against_computer.rb
The program cleans up the results of the random games, finding the best next move for each board state.
The AI will be decent after 3 million loops of the dumb bots and their random placing of X and O.

If you're wondering why I've used separate FILE.open methods for reading and writing to the data file, it is because the file shrinks at times, and truncating the data will leave legacy characters at the end.

I started adding a context manager to this, since pattern recognition with TicTacToe relies on symetry, and reducing everything to a similar context.
The context manager not implemented.
I'll probably never finish this context thing.