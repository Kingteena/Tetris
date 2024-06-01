function [movePossible] = moveTetromino(gameFigure, movement)
%MOVETETROMINO takes the gameFigure and direction to move Tetriminos as an
%input, and moves the Tertiminos specified in the figure

% Get the necessary variables from the app data
spritePositions = getappdata(gameFigure, "spritePositions");
gameMatrix = getappdata(gameFigure, "gameMatrix");
spriteNumber = getappdata(gameFigure, "spriteNumber");

spriteSize = size(spritePositions, 1);

movePossible = true; %Flag for collision logic
newSpritePositions = ones(spriteSize, 2); % Needed if there is a collision

for i = 1:spriteSize % Loop through all the elements
    row = spritePositions(i, 1);
    column = spritePositions(i, 2);
    gameMatrix(row, column) = 1; % Change the old value to 1

    % Update the positions
    switch movement
        case "down"
            % If the element is in the last row, you can't go further down
            if row == size(gameMatrix, 1)
                movePossible = false;
                break
            else
                row = row + 1; % Otherwise move down
            end
        case "right"
            % If it is in the last column, you can't go further right
            if column == size(gameMatrix, 2)
                movePossible = false;
                break
            else
                column = column + 1; % Otherwise move right
            end
        case "left"
            % If it is in the first column, you can't go further left
            if column == 1
                movePossible = false;
                break
            else
                column = column -1; % Otherwise move left
            end
        otherwise
            error("argument is not a valid movement")
    end

    % Collision logic: If the new position is not empty and
    % if the new position wasn't occupied by a piece being moved
    if gameMatrix(row, column) ~= 1 && ~ismember([row,column], spritePositions, "rows")
        movePossible = false;
        break
    else
        newSpritePositions(i, :) = [row, column]; % Update the positions array
    end
end

% if the move was not possible, don't perform the move
if ~movePossible
    newSpritePositions = spritePositions;
end

% Update matrix with the new positions
for i = 1:spriteSize
    gameMatrix(newSpritePositions(i, 1), newSpritePositions(i,2)) = spriteNumber;
end

% Update the main Variables
setappdata(gameFigure, "gameMatrix", gameMatrix)
setappdata(gameFigure, "spriteNumber", spriteNumber)
setappdata(gameFigure, "spritePositions", newSpritePositions)
end
