%/* File Info 
 %* Author:      Jia HB 
 %* CreateTime:  None
 %* LastEditor:  Jia HB 
 %* ModifyTime:  2021/7/8下午2:58:14 
 %* Description: 
%*/ 
clc; clear; close all;
f0 = 75e3;  
fs = 3*f0;   
T  = 0.01;   
N  = 1000;   
c  = 1500; 
tsig = 0:1/fs:(N-1)/fs;
sig = exp(1i*2*pi*f0*tsig); 
theta = 15;     
d = c/f0/2;   
M = 8;        
X = exp((0:M-1)'*-1i*2*pi*f0*d*sin(theta/180*pi)/c)*sig;  
snr = 10;
X = awgn(X,snr);   
THETA = linspace(-90,90,181*10);

for i = 1:length(THETA)
    a = exp(-1i*2*pi*f0*d*sin(THETA(i)/180*pi)/c*(0:M-1)');
    Y = a'*X;        
    b_CBF(i) =Y*Y'/N ;    %求平均能量
end
B_CBF = 10*log10(abs(b_CBF)/max(abs(b_CBF)));
plot(THETA,B_CBF,'linewidth',1);
set(gca, 'Xtick',-90:15:90);   
grid on;box on;xlabel('入射角/(degree)');ylabel('归一化波束输出/dB');
title('CBF算法 DOA估计');
