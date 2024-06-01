function keyboardInputController(~, eventDat, gameFigure)
%KEYBOARDINPUTCONTROLLER game controller for when a key is pressed on the keyboard
switch eventDat.Key
    case 'leftarrow' % Left
        moveTetromino(gameFigure, "left");
    case 'rightarrow' % Right
        moveTetromino(gameFigure, "right");
    case 'downarrow' % Down
        if moveTetromino(gameFigure, "down")
            % This only executes if the block was actually soft dropped
            score = getappdata(gameFigure, "score");
            score = score + 1;
            setappdata(gameFigure, "score", score)
            updateStatsGUI(gameFigure)
        end
    case 'uparrow'
        rotateTetromino(gameFigure)
    case 'space' % Hard drop
        moveWasPossible = true;
        rowsDropped = 0;
        while moveWasPossible % Keep moving down until it's impossible
            rowsDropped = rowsDropped + 1;
            moveWasPossible = moveTetromino(gameFigure, "down");
        end
        % Update the screens
        clearFilledRows(gameFigure)
        insertNewTetromino(gameFigure)

        % Update holdUsed
        setappdata(gameFigure, "holdUsed", false)

        % Update score
        score = getappdata(gameFigure, "score");
        score = score + rowsDropped + 2;
        setappdata(gameFigure, "score", score)
        updateStatsGUI(gameFigure)
    case 'c'
        holdTetromino(gameFigure)
end
%Display the updated game
updateGameGUI(gameFigure)
end