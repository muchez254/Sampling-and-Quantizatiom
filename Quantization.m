%% Copyright @ Dr Sudip Mandal
% Digital Communication Lab

%% Quantization

clear all;
close all;
clc;

%Define the message signal
tot=1;
td=0.002;
t=0:td:tot;
L=length(t);
x=sin(2*pi*t)-sin(6*pi*t);

%Plot the message signal in time domain
figure(1);
plot (t,x,'linewidth',2);
xlabel('time');ylabel('amplitude');
grid;
title('Input message signal')

%Plot the signal in frequency domain
Lf=length(x);
Lfft=2^ceil(log2(Lf)+1);
fmax=1/(2*td);
Faxis=linspace(-fmax,fmax,Lfft);
xfft=fftshift(fft(x,Lfft));

figure(2);
plot(Faxis,abs(xfft));
xlabel('frequency');ylabel('amplitude');
axis([-50 50 0 300]);
grid;

%Sample the message signal
ts=0.02;
Nfactor=round(ts/td);
xsm=downsample(x,Nfactor);
tsm=0:ts:tot;

%Plot the sampled signal(discrete time version)
figure(3);
stem(tsm,xsm,'linewidth',2);
xlabel('time');ylabel('amplitude');
grid;
title('Sampled Signal');

%Compute the spectrum of sampled signal
xsmu=upsample(xsm,Nfactor);
Lfu=length(xsmu);
Lffu=2^ceil(log2(Lfu)+1);
fmaxu=1/(2*td);
Faxisu=linspace(-fmaxu,fmaxu,Lffu);
xfftu=fftshift(fft(xsmu,Lffu));

%Plot the spectrum of the sampled siganl
figure(4);
plot(Faxisu,abs(xfftu));
xlabel('frequency');ylabel('amplitude');
title('Spectrum of Sampled signal');
grid;


% Quantization process
levels = 16;
x_min = min(xsm);
x_max = max(xsm);
step = (x_max - x_min) / levels;

% Quantize the sampled signal
x_quantized = step * round((xsm - x_min) / step) + x_min;

% Plot quantized vs. sampled signal
figure(5);
stem(tsm, xsm, 'r', 'LineWidth', 1.5); hold on;
stem(tsm, x_quantized, 'b--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Signal vs. Quantized Signal');
legend('Sampled Signal', 'Quantized Signal');
grid on;

% Quantization error
quantization_error = xsm - x_quantized;
figure(6);
stem(tsm, quantization_error, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Error');
title('Quantization Error');
grid on;

