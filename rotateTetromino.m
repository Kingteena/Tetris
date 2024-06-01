function [] = rotateTetromino(gameFigure)
%ROTATETETROMINO takes the gameFigure and moves the Tertiminos specified in
% the figure clockwise

% Get the necessary variables from the app data
oldSpritePositions = getappdata(gameFigure, "spritePositions");
gameMatrix = getappdata(gameFigure, "gameMatrix");
spriteNumber = getappdata(gameFigure, "spriteNumber");
spriteRotation = getappdata(gameFigure, "spriteRotation");

spriteSize = size(oldSpritePositions, 1);

spriteCenter = oldSpritePositions(1,:); % The first coordinate is defined to be the 'center'
translationMatrix = oldSpritePositions - spriteCenter; % The relative coordinate from the center
% Rotate 90 degrees clockwise by multiplying it by the appropriate matrix
rotatatedTranslationMatrix = translationMatrix * [0, -1; 1, 0];

% Implementing wall kicking - The actual values are mapped from the Super
% rotation system in the Tetris Wiki. However there is no code given in the
%  website so I belive the following code should be still given credit for
switch spriteNumber
    case 6 % O - Tetromino
        switch spriteRotation 
            case 1
                kickTranslations = [-1,0];
            case 2
                kickTranslations = [0,1];
            case 3
                kickTranslations = [1,0];
            case 4
                kickTranslations = [0,-1];
        end
    case 3 % I - Tetromino
        switch spriteRotation
            case 1
                kickTranslations = [0, 1; 0, -1; 0, 2; 1, -1; -2, 2];
            case 2
                kickTranslations = [1, 0; 1, -1; 1, 2; -1, -1; 2, 2];
            case 3
                kickTranslations = [0, -1; 0, 1; 0, -2; -1, 1; 2, -2];
            case 4
                kickTranslations = [-1, 0; -1, 1; -1, -2; 1, 1; -2, -2];
        end
    otherwise % All other Tetrominos
        switch spriteRotation
            case 1
                kickTranslations = [0,0; 0,-1; -1,-1; 2,0; 2,-1];
            case 2
                kickTranslations = [0,0; 0,1; 1,1; -2,0; -2, 1];
            case 3
                kickTranslations = [0,0; 0,1; -1,1; 2,0; 2,1];
            case 4
                kickTranslations = [0,0; 0,-1; 1,-1; -2,0; -2,-1];
        end
end

%Get the new Sprite positons
rotatedSpritePositions = spriteCenter + rotatatedTranslationMatrix;
newSpritePositions = ones(2,4);


% Update the old positions with 1
for i = 1:spriteSize % Loop through all the elements
    row = oldSpritePositions(i, 1);
    column = oldSpritePositions(i, 2);
    gameMatrix(row, column) = 1; % Change the old value to 1
end

movePossible = false;
i = 1;
% Loop until we found a possible move or we exceeded the max possible stuff
while ~movePossible && i <= size(kickTranslations,1)
    movePossible = true; % Initially set the flag to true

    % Try the i-th kick rottion
    newSpritePositions = rotatedSpritePositions + kickTranslations(i,:);

    % Collision logic
    for j = 1:spriteSize
        row = newSpritePositions(j,1);
        column = newSpritePositions(j,2);

        % Test for all the events that are illegal
        % NOTE: the order matters here to ensure we do not accidenally
        % evaluate the position of a element out of bounds
        if  row < 1 || row > size(gameMatrix,1) ... % The row is out of range
                || column < 1 || column > size(gameMatrix,2)... % Column is out of range
                || gameMatrix(row, column) ~= 1 ... % If the element is not empty
                && ~ismember([row,column], oldSpritePositions, "rows")... % And was not occupied by something currenttly being rotated

            % If it was not possible, set the flag back to false and skip
            % to the next rotation
            movePossible = false;
            break
        end
    end

    i = i + 1;
end

% If the rotation was not possible, reset the positions
if ~movePossible
    newSpritePositions = oldSpritePositions;
else % Record the rotation
    spriteRotation = spriteRotation + 1;
    if spriteRotation == 5
        spriteRotation = 1;
    end
end

% Update matrix with the new positions
for i = 1:spriteSize
    gameMatrix(newSpritePositions(i, 1), newSpritePositions(i,2)) = spriteNumber;
end


% Update the main Variables
setappdata(gameFigure, "gameMatrix", gameMatrix)
setappdata(gameFigure, "spriteNumber", spriteNumber)
setappdata(gameFigure, "spritePositions", newSpritePositions)
setappdata(gameFigure, "spriteRotation", spriteRotation)

end