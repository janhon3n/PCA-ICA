% Plots the individual rows of the given matrix using subplot()
%
% Parameters:
%   mat - the matrix
%   rowCount - the amount of rows in the subplot
%   colCount - the amount of rows to draw from the matrix, each to
%               different column of the subplot
%   row - the row of subplot to draw the rows of the matrix
%
function [] = plotMatrix(mat, rowCount, colCount, row, titl)
    [r, c] = size(mat);
    e = min([colCount, r]);
    for i = 1:e
        subplot(rowCount,colCount,(row-1) * colCount + i);
        plot(mat(i,:));
        title(strcat(titl, {' '}, num2str(i)));
    end
end