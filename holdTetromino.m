function holdTetromino(gameFigure)
% HOLDTETROMINO puts the current Tetromino on hold and replaces it with the
% Tetromino previously put on hold. If there is none, it calls the next
% Tetromino.
% gameFigure is the figure the game is displayed on
% holdUsed is a flag to make sure that you can only use the hold functionality
% Tetromino
% holdSpriteNumber is used to store the sprite on hold
holdUsed = getappdata(gameFigure, "holdUsed");
if ~holdUsed
    % Clear the old positions
    spritePositions = getappdata(gameFigure, "spritePositions");
    gameMatrix = getappdata(gameFigure, "gameMatrix");
    for i = 1:length(spritePositions)
        gameMatrix(spritePositions(i,1), spritePositions(i,2)) = 1;
    end
    setappdata(gameFigure, "gameMatrix", gameMatrix)
holdSpriteNumber = getappdata(gameFigure, "holdSpriteNumber");
spriteNumber = getappdata(gameFigure, "spriteNumber");
if holdSpriteNumber == 0
    % If there was no Tetromino on hold, insert a brand new one
    insertNewTetromino(gameFigure)
else
    % insert the Tetromino that was on hold as the current tetromino
    setappdata(gameFigure, "spriteNumber", holdSpriteNumber)
    generateCurrentTetromino(gameFigure)
end
% Save the curent sprite number as the hold sprite number
setappdata(gameFigure, "holdSpriteNumber", spriteNumber) 

% save holUsed
setappdata(gameFigure, "holdUsed", true)

% Update the Hold Tetromino Plot
updateImageSubplotGUI(gameFigure, "hold")
end

end
