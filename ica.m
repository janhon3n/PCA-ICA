% setup variables
L = 50000; % samples per vector
RowsToAnalyze = 4; % rows of the matricies to input to the analysing functions
RowsToFind = 2; % rows to output from the analysing functions (number of signals we are looking for)
ICAType = 'kurtosis'; % Type of ica for function fastICA. 'kurtosis' or 'negentropy'


% constants
f = 44100; % sampling frequency
Ts = 1/f; % sample time

fprintf('Searching for %i signals from the group of %i signals\n', RowsToFind, RowsToAnalyze);

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
plotMatrix(S, 4, RowsToAnalyze, 1, 'Original signal');

% Plot the mixed signals
plotMatrix(X, 4, RowsToAnalyze, 2, 'Mixed signal');

% Do the different types of analysis
Y1 = fastICA(X(1:RowsToAnalyze, :), RowsToFind, ICAType, 0);
Y2 = kICA(X(1:RowsToAnalyze, :), RowsToFind);
Y3 = PCA(X(1:RowsToAnalyze, :), RowsToFind);

% Normalize results to range 0-1
Y1 = normalizeAudio(Y1);
Y2 = normalizeAudio(Y2);
Y3 = normalizeAudio(Y3);

% The analysis mixes up the order of the signals so we need to match them
% ourselves.
% The matrices outputted from the analysis functions are matched by finding
% the original signal in S that is closest to each of the outputted
% signals.
Y1 = matchMatrices(S, Y1, RowsToFind); 
Y2 = matchMatrices(S, Y2, RowsToFind);
Y3 = matchMatrices(S, Y3, RowsToFind);

plotMatrix(Y1, 4, RowsToAnalyze, 3, 'fastICA result');
plotMatrix(Y3, 4, RowsToAnalyze, 4, 'PCA result');

% Print out the results
for i = 1:RowsToFind
    d = calculateDifference(S(i,:), Y1(i,:));
    fprintf('The difference in signal #%i from fastICA: %f\n', i, d);
end
for i = 1:RowsToFind
    d = calculateDifference(S(i,:), Y2(i,:));
    fprintf('The difference in signal #%i from kICA: %f\n', i, d);
end
for i = 1:RowsToFind
    d = calculateDifference(S(i,:), Y3(i,:));
    fprintf('The difference in signal #%i from PCA: %f\n', i, d);
end
