function updateImageSubplotGUI(gameFigure, subplotTitle)
%UPDATEIMAGESUBPLOTGUI updates the Hold or the Next subplots on the GUI
%with the relevant data. 
% gameFigure - the figure the game is played on
% subplot - the subplot to update, either "hold" or "next"

%Load the relevant subplot
switch subplotTitle
    case "hold"
        subplotPosition = [0.0315 0.65 0.2 0.3];
        spriteNumber = getappdata(gameFigure, "holdSpriteNumber");
        
    case "next"
        subplotPosition =[0.7615 0.65 0.2 0.3];
        nextTetrominos = getappdata(gameFigure, "nextTetrominos");
        spriteNumber = nextTetrominos(1);
    otherwise
        error("Invalid subplot")
end
subplot('Position',subplotPosition)

switch spriteNumber
    case 2 % T-Tetromino
        imageMatrix = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 2, 1, 1; 1, 2, 2, 2, 1;1, 1, 1, 1, 1;];
    case 3 % I-Tetromino
        imageMatrix = [1, 1, 1, 1; 1, 1, 1, 1; 3, 3, 3, 3; 1, 1, 1, 1];
    case 4 % J - Tetromino
        imageMatrix = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 4, 1, 1, 1; 1, 4, 4, 4, 1; 1, 1, 1, 1, 1;];
    case 5 % L - Tetromino
        imageMatrix = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 1, 5, 1; 1, 5, 5, 5, 1; 1, 1, 1, 1, 1];
    case 6 % O - Tetromino
        imageMatrix = [1, 1, 1, 1; 1, 6, 6, 1; 1, 6, 6, 1; 1, 1, 1, 1];
    case 7 % S - Tetromino
        imageMatrix = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 1, 7, 7, 1; 1, 7, 7, 1, 1; 1, 1, 1, 1, 1];
    case 8 % Z - Tetromino
        imageMatrix = [1, 1, 1, 1, 1; 1, 1, 1, 1, 1; 1, 8, 8, 1, 1; 1, 1, 8, 8, 1; 1, 1, 1, 1, 1;];
end
colormap( ...
    uint8([0,0,0; ... % Black Background
    170,0,240; ... % Purple T-Tetromino
    0,240,240; ... % Light Blue I-Tetromino
    0,0,240; ... % Dark Blue J-Tetroino
    240,160,0; ... % Orange L-Tetromino
    240,240,1; ... % Yellow O-Tetromino
    0,240,0; ... % Green S-Tetromino
    240,0,0; ...% Red Z-Tetromino
    255,255,255])) % White Filled Row

% Display the start
image(imageMatrix)

% Set the display settings
title(subplotTitle.upper)
axis tight;
axis equal;
set(gca, 'XTick', [], 'YTick', [], 'FontSize', 13)
end 
