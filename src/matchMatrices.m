% Matches the rows in the second matrix with the rows of the first one
% by finding the ones that are closest to each other in terms of euclidean
% distance.
% If matrices row counts dont match, add all zero rows to mat2
%
% Parameters:
%   mat1 - first matrix, the one that will be sorted
%   mat2 - second matrix
%   rows - the amount of rows to sort, starting with 1
%
% Returns:
%   mat - sorted version of mat2
%
function [mat] = matchMatrices(mat1, mat2, rows)
    mat = mat2;
    [r, c] = size(mat);
    [r2, c2] = size(mat1);
    while r2 > r
        r = r + 1;
        mat(r, :) = zeros(1, c);
    end
    for i = rows:-1:1 % start from the end row => priorisize the first rows
        [index, inverse, row] = findClosest(mat1, mat(i, :)); % find the index of the closest row
        temp = mat(i, :); % swap the rows
        mat(i, :) = mat(index, :);
        mat(index, :) = temp;
        if inverse == 1 % if inverse then inverse the row
            mat(i, :) = mat(i, :) * -1;
        end
    end
end


