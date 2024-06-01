function [] = clearFilledRows(gameFigure)
% CLEARFILLEDROWS checks for any filled rows in the gameMatrix stored in
% the appdata of gameFigure and if they exist, clears them. It also updates
% the score

% get the gameMatrix, level, score from the appdata
gameMatrix = getappdata(gameFigure, "gameMatrix");
level = getappdata(gameFigure, "level");
score = getappdata(gameFigure, "score");

% Counts how many rows cleared - necessary for score
rowsCleared = 0;

% Looping through all the rows
for i = 1:size(gameMatrix, 1)
    % If none of the squares are empty, the logical array is a zero array,
    % which should sum to zero
    if sum(gameMatrix(i,:) == 1) == 0

        % If it isn't the top-most row
        if i>1
            gameMatrix(2:i, :) = gameMatrix(1:i-1, :); % Shift everything down
        end
        gameMatrix(1, :) = ones(1, size(gameMatrix, 2)); % Clear first row

        rowsCleared = rowsCleared + 1;

    end
end

% Calculate score
switch rowsCleared
    case 0
        baseScore = 0;
    case 1
        baseScore = 40;
    case 2
        baseScore = 100;
    case 3
        baseScore = 300;
    case 4
        baseScore = 1200;
    otherwise
        error("Impossible amount of lines cleared")
end
score = score + baseScore * level;

% Update level
level = level + rowsCleared;

% Update the main variable
setappdata(gameFigure, "gameMatrix", gameMatrix)
setappdata(gameFigure, "level", level)
setappdata(gameFigure, "score", score)

% Update the GUI for stats
updateStatsGUI(gameFigure)
end