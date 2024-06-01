function updateStatsGUI(gameFigure)
%UPDATESTATSGUI takes in the figure the game is displayed on and updates
%the stats subplot with the data stored in the gameFigure appdata
score = getappdata(gameFigure, "score");
level = getappdata(gameFigure, "level");
StatsPos = [0.75, 0.4 0.225, 0.2];
subplot('Position',StatsPos)
cla()
scoreText = sprintf("Score: %d", score);
levelText = sprintf("Level: %d", level);
text(0.05,0.75,scoreText,'FontSize',10);
text(0.05,0.25,levelText,'FontSize',10);
end