
% Finds the row of the given matrix that is closest to the given vector
% Also checks inversed versions of each rows (each sample *= -1)
%
% Parameters:
%   mat - The matrix
%   vec - The vector
%
% Returns:
%   index - The index of the row that is closest to the given vector
%   inverse - True if the row is inversed, False if not
%   row - the closest row in mat, inversed if closest that way
%
function [index, inverse, row] = findClosest(mat, vec)
    [r, c] = size(mat);
    if length(vec) ~= c
        error("Vector length and matrix column count do not match.");
    else        
        min = calculateDifference(mat(1,:), vec);
        inverse = 0;
        index = 1;
        row = mat(1,:);
        for i = 2:r
            dif = calculateDifference(mat(i,:), vec);
            if(dif < min)
               min = dif;
               index = i;
               row = mat(i, :);
            end
        end
        for i = 1:r
            dif = calculateDifference(mat(i,:), vec * -1);
            if(dif < min)
               min = dif;
               index = i;
               inverse = 1;
               row = mat(i, :) * -1;
            end
        end
    end
end
