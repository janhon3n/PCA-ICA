%ICA testi
t = 0:0.01:8;

x1 = audioread('samples/wave_1.wav')';
x2 = audioread('samples/wave_2.wav')';
x3 = audioread('samples/wave_4.wav')';

X = normalizeAudio([x1;x2;x3]);
[r, samples] = size(X);

subplot(3,3,1);
plot(X(1,:));
subplot(3,3,2);
plot(X(2,:));
subplot(3,3,3);
plot(X(3,:));

A = [[15,22,5]',[2,15,5]', [2,5,6]'];
S = A*X;
subplot(3,3,4);
plot(S(1,:));
subplot(3,3,5);
plot(S(2,:));
subplot(3,3,6);
plot(S(3,:));

[Zica, W, T, mu] = kICA(S, 3);
Zica = normalizeAudio(Zica);

error = zeros(1,3);
indicies = zeros(1,3);

for i = 1:3
    [error(i), indicies(i)] = findClosest(X(i,:), Zica);
    subplot(3,3,7+(mod(indicies(i)-1, 3)));
    plot(Zica(i,:));
end

[error1, error2, error3];

% Find the signal in Sg that is closest to the given signal s
function [err, index] = findClosest(sig, Sg)
    [x,samples] = size(sig);
    Diff = zeros(1, samples);
    [rows, cols] = size(Sg);
    for i = 1:rows
        for s = 1:samples
            Diff(s) = (Sg(i,s) - sig(s));
        end
        Err(i) = sum(Diff.^2);
    end
    for i = 1:rows
        for s = 1:samples
            Diff(s) = (Sg(i,s) + sig(s));
        end
        Err(i+3) = sum(Diff.^2);
    end
    [err, index] = min(Err);
end