% Calculates the difference between two vectors.
% The diffenrece is the euclidean distance between the vectors.
% It is calculated with the formula Sqrt((a1 - b1)^2 + (a2 - b2)^2 + .... + (an - bn)^2)
%
% Parameters:
%   vec1 - first vector
%   vec2 - second vector
%
% Returns:
% diff - The difference between the vectors
%
function [diff] = calculateDifference(vec1, vec2)
    if length(vec1) ~= length(vec2)
        error('Vectors must have the same length.');
    else
        diff = 0;
        for i = 1:length(vec1)
            diff = diff + (vec1(i) - vec2(i))^2;
        end
        diff = sqrt(diff);
    end
end