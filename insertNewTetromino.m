function insertNewTetromino(gameFigure)
% INSERTNEWTETROMINO - Generates a the list of next Tetrominos and places
% it in the "nextTetrominos" variable in gameFigure.
% Calls generateCurrentTetromino to place it in gameMatrix

% Get the nextTetrominos
nextTetrominos = getappdata(gameFigure, "nextTetrominos");

% If There's less than 2 in next Tetrominos, generate more
if length(nextTetrominos) < 2
    % Select Tetrominos from the "Bag to randomise them"
    newTetrominos = zeros(1,7);
    bag = 2:8; % spriteNumbers are between 2 and 8
    for i = 7:-1:1
        pick = randi(i); % Generate a number between 1 and the max number
        newTetrominos(i) = bag(pick); % Add it to the bag
        bag = bag([1:pick-1, pick+1:i]); % Exclude the already picked Tetromino from the bag
    end
    nextTetrominos = [nextTetrominos, newTetrominos];
end

% Get the spriteNumber from nextTetrominos and remove that number
spriteNumber = nextTetrominos(1);
nextTetrominos = nextTetrominos(2:end);

% Save the appdata
setappdata(gameFigure, "spriteNumber", spriteNumber)
setappdata(gameFigure, "nextTetrominos", nextTetrominos)

% Update the next Tetromino subplot
updateImageSubplotGUI(gameFigure, "next")

generateCurrentTetromino(gameFigure)
end