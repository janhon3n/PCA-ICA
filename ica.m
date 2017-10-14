f = 44100;
Ts = 1/f;
L = 50000;

s1 = audioread('samples/wave_1.wav')';
s2 = audioread('samples/wave_2.wav')';
s3 = audioread('samples/wave_3.wav')';
s4 = audioread('samples/wave_4.wav')';
S = [s1;s2;s3;s4];
S = normalizeAudio(S);

subplot(3,2,1);
plot(S(1,:));
subplot(3,2,2);
plot(S(2,:));

Sf = fft(S, L, 2);
Sf = abs(Sf/L);
Sf = Sf(:,1:L/2+1);

subplot(3,2,3);
plot(Sf(1,:));
subplot(3,2,4);
plot(Sf(2,:));

x1 = audioread('samples/mixed_1.wav')';
x2 = audioread('samples/mixed_2.wav')';
x3 = audioread('samples/mixed_3.wav')';
x4 = audioread('samples/mixed_4.wav')';
X = [x1;x2;x3;x4];
X = normalizeAudio(X);

Y = PCA(X,2);
Y = normalizeAudio(Y);
subplot(3,2,5);
plot(Y(1,:));
subplot(3,2,6);
plot(Y(2,:));
function p = plotMatrix(mat, rowCount, colCount, row)
    [r, c] = size(mat);
    e = min([colCount, r]);
    for i = 1:e
        subplot(rowCount,colCount,(row-1) * colCount + i);
        plot(mat(i,:));
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