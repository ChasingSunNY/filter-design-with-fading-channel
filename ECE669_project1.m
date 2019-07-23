z = normrnd(0,sqrt(1/2)).*randn(100,1);
y = normrnd(0,sqrt(1/2)).*randn(100,1);% 1A
h = z+i*y;
fms = z.^2+y.^2;
meanfms= mean(fms);%1B
syms x
% x=0:0.01:5;
f=2*x.*exp(-x.^2);
%plot(x,f)
c = fms;
f_c=exp(-x);
%plot(x,f_c);
Ec= int(x*f_c,x,0,inf);%1C-3
equality= eq(Ec,meanfms); %1C-4
syms s
Es = mean(s^2);
D= mean(abs(h)*(s^2));
eq(D,Es);
h1= normrnd(0,sqrt(1/2)).*randn(100,1);
D1=mean(abs(h1)*(s^2));
%Es_square= Es
%signal= abs((abs(h)*s)^2)*f;
%Erf= int(siganl,x,0,inf);  1C-567
clear 
syms c EbN0 positive %definite c and EbN0 
instantBER = 0.5*(1-erf(sqrt(c*EbN0))); %definite the instant BER equation
BER_fading= int(instantBER*exp(-c),c,0,inf); %calculate the mean value of BER to get the continus BER
pretty((BER_fading)) % make the equation looks better
