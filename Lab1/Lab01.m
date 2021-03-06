% Lab01.m
% Description - Completes Lab number 1
% Author: Robert Irwin

%% Section 1
%generate function for lab 1
clear; clc;

%Fundamental Period
per = .002; %s


%time vector
t = 0:1e-6:per;

ts = per/length(t);
%initialize the signal x(t)
x = zeros(1,length(t));

%generate the first period of the signal
    for i = 1:length(t)
        if (t(i) <= .0002) 
            x(i) = 10000*t(i);
        elseif (.0002 < t(i)) && (t(i) <= .0006)
            x(i) = -10000*(t(i)-.0002)+2;
        else 
            x(i) = 0;
        end
    end
%put vector into correct format

sig.signals.values=x';
sig.time=[];
% for i = 1:length(t)
%     sig(i,1) = t(i); %first column must be timestamps
%     sig(i,2) = x(i); %second column is data values
% end

    
 %plot(t,x) 
 
%% power calculations
% find the average power

%% numerically
%Section 2 -answers number 1
%run section above first

%initialize vector
instpow = zeros(1,length(x));

for i = 1:length(x)
    instpow(i) = (x(i))^2*ts;
end

avpow = sum(instpow)/per;

%% symbolically
%section 3 - answers number 1
clear;clc;
syms t

x = 10000*t*heaviside(t)-10000*t*heaviside(t-.0002)+(-10000*t+4)*...
    heaviside(t-.0002)-(-10000*t+4)*heaviside(t-.0006);

avpow = int(x^2,t,0,.002)/.002;
avpow = eval(avpow);

tnew = eval(subs(t, 0:1e-6:.002));
xnew = eval(subs(x,tnew));
%plot(tnew,xnew)

%% add the coefficients from the spectrum analyzer -answers number 3
%section 4
coeff = [9.9 28.136 56.842 56.78 29.373 5.655]*1e-3;

peravpow = zeros(1,length(coeff));
%calculate percent average power
for i = 1:length(coeff)
    if i == 1
        peravpow(i) = ((coeff(1))/avpow)*100;
    else
        peravpow(i) = (((coeff(1)) + 2*sum(coeff(2:i)))/avpow)*100;
    end
end

%for plotting
n = 1:length(coeff);

figure(1)
plot(n,peravpow);
title('Percent of Average Power per  DFT Coefficient')
xlabel('Number of Coefficients')
ylabel('Percent of Total Average Power')

%% Section 6 - answers number 3
%run section 3 First
%calculate the DFT

per = .002;
k = 0:5;
ft = 1/per;
DFTcoeff = zeros(1,length(k));
f = x*exp(j*2*pi*k*ft*t);
for i = 1:length(k);
    f = x*exp(-j*2*pi*k(i)*ft*t);
    %integrate
    DFTcoeff(i) = int(f,t,0,per)/per;
end
DFTcoeff = abs(DFTcoeff);
coeff = DFTcoeff.^2;

%% Section 7 - answers question 4
clear;clc;
syms t

per = .002;
%average of the signal
x = 10000*t*heaviside(t)-10000*t*heaviside(t-.0002)+(-10000*t+4)*...
    heaviside(t-.0002)-(-10000*t+4)*heaviside(t-.0006);

avsig = int(x,t,0,per)/per;
avsig = eval(avsig);

%RMS of signal

x = 10000*t*heaviside(t)-10000*t*heaviside(t-.0002)+(-10000*t+4)*...
    heaviside(t-.0002)-(-10000*t+4)*heaviside(t-.0006);

RMS = sqrt(int(x^2,t,0,per)/per);
RMS = eval(RMS);