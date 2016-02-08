####play_dumb_bots.rb
This spins up two objects that just generate random boards, and there's a seperate function that looks for win conditions.
When an object gets a win condition, the program loops back through the winning object's board states and next moves, giving each move another point.
If an object gets a loss, then each move for the previous state loses a point.

####play_against_computer.rb
The program cleans up the results of the random games, finding the best next move for each board state.
The AI will be decent after 3 million loops of the dumb bots and their random placing of X and O.

The issue with this is this is my first Ruby program, and I can't use callbacks yet.
So this means the file can't finish saving before the next load and save, after a certain file size. Therefore it becomes invalid JSON.
Learn to use callbacks, is the answer.

