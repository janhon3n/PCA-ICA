% setup variables
f = 44100; % sampling frequency
Ts = 1/f; % sample time
L = 50000; % samples per vector

% Load audio files into matrices
s1 = audioread('samples/wave_1.wav')';
s2 = audioread('samples/wave_2.wav')';
s3 = audioread('samples/wave_3.wav')';
s4 = audioread('samples/wave_4.wav')';
S = [s1(1:L);s2(1:L);s3(1:L);s4(1:L)];
S = normalizeAudio(S);

x1 = audioread('samples/mixed_1.wav')';
x2 = audioread('samples/mixed_2.wav')';
x3 = audioread('samples/mixed_3.wav')';
x4 = audioread('samples/mixed_4.wav')';
X = [x1(1:L);x2(1:L);x3(1:L);x4(1:L)];
X = normalizeAudio(X);

% Plot the original signals
plotMatrix(S, 3, 4, 1);

% Plot the mixed signals
plotMatrix(X, 3, 4, 2);

Sf = fft(S, L, 2);
Sf = abs(Sf/L);
Sf = Sf(:,1:L/2+1);

Y = PCA(X,2);
Y = normalizeAudio(Y);

matchMatrices(S, Y);

plotMatrix(Y, 3, 4, 3); 



function p = plotMatrix(mat, rowCount, colCount, row)
    [r, c] = size(mat);
    e = min([colCount, r]);
    for i = 1:e
        subplot(rowCount,colCount,(row-1) * colCount + i);
        plot(mat(i,:));
    end
end

% Matches the rows in the second matrix with the rows of the first one
% by finding the ones that are closest to each other in terms of euclidean
% distance.
%
% Parameters:
%   mat1 - first matrix
%   mat2 - second matrix, the one that will be sorted
%
% Returns:
%   mat - sorted version of mat2
%
function [mat] = matchMatrices(mat1, mat2)
    [r, c] = size(mat2);
    for i = r:1
        index = findClosest(mat1, mat2(i)); % find the index of the closest row
        row = mat2(i,:) % swap the closist row to its place
        mat2(i, :) = mat2(index, :);
        mat2(index, :) = row;
    end
    mat = mat2;
end


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
%   the closest row in mat, inversed if closest that way
%
function [index, inverse, row] = findClosest(mat, vec)
    [r, c] = size(mat);
    if length(vec) ~= c
        error("Vector length and matrix column count do not match.");
    else        
        min = calculateDifference(mat(1,:), vec);
        inverse = false;
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
            dif = calculateDifference(mat(i,:) * -1, vec);
            if(dif < min)
               min = dif;
               index = i;
               inverse = true;
               row = mat(i, :) * -1;
            end
        end
    end
end


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
        error("Vectors must have the same length.");
    else
        diff = 0;
        for i = 1:length(vec1)
            diff = diff + (vec1(i) - vec2(i))^2;
        end
        diff = sqrt(diff);
    end
end