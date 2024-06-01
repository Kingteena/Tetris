function generateCurrentTetromino(gameFigure)

% Get the gameMatrix from the app data
gameMatrix = getappdata(gameFigure, "gameMatrix");
spriteNumber = getappdata(gameFigure, "spriteNumber");

% Figure out the "Center" of the game from which we generate our Tetromino
gameCenterColumn = size(gameMatrix, 2)/2;
spriteCenter = [2, gameCenterColumn]; % Row must start at two or we end up off screen

% Select the appropriate translation for the type of Tetromino
switch spriteNumber
    case 2 % T-Tetromino
        translationMatrix = [0,0; 0,-1; 0,1; -1,0 ];
    case 3 % I-Tetromino
        translationMatrix = [0,0; 0,-1; 0,1; 0,2 ];
    case 4 % J - Tetromino
        translationMatrix = [0,0; 0,-1; 0,1; -1,-1 ];
    case 5 % L - Tetromino
        translationMatrix = [0,0; 0,-1; 0,1; -1,1 ];
    case 6 % O - Tetromino
        translationMatrix = [0,0; 0,1; -1,0; -1,1 ];
    case 7 % S - Tetromino
        translationMatrix = [0,0; 0,-1; -1,0; -1,1];
    case 8 % Z - Tetromino
        translationMatrix = [0,0; -1,-1; 0,1; -1,0];
end

% Add the translation to the center to get our spritePositions
spritePositions = ones(size(translationMatrix));
for i = 1:size(spritePositions, 1)
    spritePositions(i,:) = translationMatrix(i, :) + spriteCenter;
end

% Update the matrix with the initial positions
for i = 1:size(spritePositions,1)
    row = spritePositions(i, 1);
    column = spritePositions(i, 2);

    % Game over logic
    if gameMatrix(row, column) ~= 1
        setappdata(gameFigure, "gameOver", true)
        set(gameFigure, 'KeyPressFcn', [])

    end
    gameMatrix(row, column) = spriteNumber;
end

% Set the rotation data
spriteRotation = 1;

setappdata(gameFigure, "gameMatrix", gameMatrix)
setappdata(gameFigure, "spritePositions", spritePositions)
setappdata(gameFigure, "spriteRotation", spriteRotation)
end