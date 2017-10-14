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
