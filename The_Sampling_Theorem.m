%% Copyright @ Dr Sudip Mandal
% Digital Communication Lab

%% ANALYSIS OF SAMPLING THEOREM
 
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



