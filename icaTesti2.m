s1 = audioread('samples/mixed_1.wav')'


s2 = audioread('samples/mixed_2.wav')'
s3 = audioread('samples/mixed_3.wav')'
s4 = audioread('samples/mixed_4.wav')'

M = [s1;s2;s3;s4];


[Zica, W, T, mu] = kICA(M, 2);

m1 = normalizeAudio(Zica(1,:));
m2 = Zica(2,:);

plot(m1);


