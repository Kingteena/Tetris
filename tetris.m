% The main controller Script for the game. Run this script to play Tetris!

%clear all varibles as it is good practices to do so
clear  

% Size of the gameMatrix
gameRows = 20;
gameColumns = 10;

% Initalise the matrix the game is going to be played on
gameMatrix = ones(gameRows, gameColumns);

% Set up the figures and appdata
gameFigure = figure;
set(gameFigure, 'name', 'Tetris', 'KeyPressFcn', {@keyboardInputController, gameFigure})
setappdata(gameFigure, "gameMatrix", gameMatrix)

% Initialise appdata variables
level = 1;
score = 0;
holdSpriteNumber = 0;
holdUsed = false;
gameOver = false;
setappdata(gameFigure, "level", level)
setappdata(gameFigure, "score", score)
setappdata(gameFigure, "holdSpriteNumber", holdSpriteNumber)
setappdata(gameFigure, "holdUsed", holdUsed)
setappdata(gameFigure, "gameOver", gameOver)

% Initialise the First Tetromino
insertNewTetromino(gameFigure)

% Subplots 
% Hold Tetromino Plot
holdPos = [0.0315 0.65 0.2 0.3];
subplot('Position',holdPos)
image(1)
title('HOLD')
axis tight;
axis equal;
set(gca, 'XTick', [], 'YTick', [], 'FontSize', 13)

% How to Play
textPos = [0.025, 0.05 0.225, 0.55];
subplot('Position',textPos)
text(0.05,0.95,"HOW TO PLAY",'FontSize',10)
text(0.05,0.85,"It's the classic game of",'FontSize',8)
text(0.05,0.81,"Tetris! The key bindings",'FontSize',8)
text(0.05,0.77,"are as follows:",'FontSize',8)
text(0.05,0.67,"left arrow key - move left",'FontSize',7)
text(0.05,0.63,"right arrow key - move right",'FontSize',7)
text(0.05,0.59,"up arrow key - rotate piece",'FontSize',7)
text(0.05,0.55,"down arrow key - soft drop",'FontSize',7)
text(0.05,0.51,"space bar - hard drop",'FontSize',7)
text(0.05,0.47,"c - hold",'FontSize',7)
text(0.05,0.37,"Fill a line to clear it!",'FontSize',8)
text(0.05,0.32,"Earn Points by clearing",'FontSize',8)
text(0.05,0.27,"lines, soft dropping or",'FontSize',8)
text(0.05,0.22,"hard dropping",'FontSize',8)
text(0.05,0.17, "The game ends when no", "FontSize", 8)
text(0.05,0.12, "new piece can be added", "FontSize", 8)
text(0.05,0.04, "GOOD LUCK!", "FontSize", 9)
set(gca, 'XTick', [], 'YTick', [])

% Stats
StatsPos = [0.75, 0.4 0.225, 0.2];
subplot('Position',StatsPos)
text(0.05,0.75,"Score: 0",'FontSize',10);
text(0.05,0.25,"Level: 0",'FontSize',10);
set(gca, 'XTick', [], 'YTick', [])

% Initalise the song
%NOTE - all code dealing with playback and control of audio were taken from
%the MATLAB Forums
[y,Fs] = audioread('tetrisThemeSong.mp3');
themeSong = audioplayer(y, Fs);

%Display the inial figure
updateGameGUI(gameFigure);
pause(1)

% Loop until it reaches the bottom
while ~gameOver
    moveWasPossible = moveTetromino(gameFigure, "down");

    % If the piece cannot move down further, send in a new one
    if ~moveWasPossible
        clearFilledRows(gameFigure)
        insertNewTetromino(gameFigure)

        % The new piece can be held, so Update holdUsed
        setappdata(gameFigure, "holdUsed", false)
    end
    updateGameGUI(gameFigure);

    % Update level variable
    level = getappdata(gameFigure, "level");

    % Wait until the next automatic move based on the level
    timeToWait = 1 - 0.03 * level;
    if timeToWait < 0.2
        timeToWait = 0.2;
    end
    pause(timeToWait)
    gameOver = getappdata(gameFigure, "gameOver");

    % Keep playing the song
    play(themeSong)
end
% When game is over:
stop(themeSong) % Auditary cue that the game is over
pause(1) % Show the mistake

% Display final score and close figure
score = getappdata(gameFigure, "score");
fprintf("Game over!\n")
fprintf("Final score was: %d\n", score)
close(gameFigure);
