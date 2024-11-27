%% Copyright @ Dr Sudip Mandal
% Digital Communication Lab

%% Reconstruction from Sampled Signal

clear all;
close all;
clc;

%Define Parameters and Generate Signal
tot=1;
td=0.002;
t=0:td:tot;
L=length(t);
x=sin(2*pi*t)-sin(6*pi*t);

ts=0.02;

%Upsample and zero fill the sampled signal
Nfactor=round(ts/td);

xsm=downsample(x,Nfactor);

xsmu=upsample(xsm, Nfactor);

%Frequency Spectrum of Sampled Siganl
Lfu=length(xsmu);
Lffu=2^ceil(log2(Lfu)+1);
fmaxu=1/(2*td);
Faxisu=linspace(-fmaxu,fmaxu,Lffu);
xfftu=fftshift(fft(xsmu,Lffu));

%Plot the spectrum of the Sampled Signal
figure (1);
plot(Faxisu,abs(xfftu));
xlabel('Frequency');ylabel('Amplitude');
axis([-120 120 0 300/Nfactor]);
title('Spectrum of Sampled Signal');
grid;

%Design a Low Pass Filter
BW=10;
H_lpf=zeros(1,Lffu);
H_lpf(Lffu/2-BW:Lffu/2+BW-1)=1;

figure(2);
plot(Faxisu,H_lpf);
xlabel('Frequency');ylabel('Amplitude');
title('Transfer function of LPF');
grid;

%Filter the Sampled Signal
x_recv=Nfactor*((xfftu)).*H_lpf;

figure(3);
plot(Faxisu,abs(x_recv));
xlabel('Frequency');ylabel('Amlpitude');
axis([-120 120 0 300]);
title('Spectrum of LPF output');
grid;

%Inverse FFT for Time domain representation 
x_recv1=real(ifft(fftshift(x_recv)));
x_recv2=x_recv1(1:L);

figure (4);
plot(t,x,'r',t,x_recv2,'b--','linewidth',2);
xlabel('Time');ylabel('Amplitude');
title('Original vs.Reconstructed Message Signal');
grid;





