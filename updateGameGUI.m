function [] = updateGameGUI(gameFigure)
% UPDATEGAMEGUI displays game matrix as GUI using the values as color numbers
gamePos = [0.25 0.025 0.5 0.95];
subplot('Position',gamePos)

gameMatrix = getappdata(gameFigure, "gameMatrix");

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
image(gameMatrix)

% Set the display settings
axis tight;
axis equal;
set(gca, 'XTick', [], 'YTick', [])
end