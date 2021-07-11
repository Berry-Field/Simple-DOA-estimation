%%/* File Info 
% * Author:      Jia HB 
% * CreateTime:  2021/7/11下午9:59:23 
% * LastEditor:  Jia HB 
% * ModifyTime:  2021/7/11下午10:07:35 
% * Description: 
%%*/ 

clc; clear; close all;
N = 8;                     
M = 1;                                                                     
theta = 15;                                                         
snr = 10;                                                                   
K = 1024;  
dd = 0.5;                               
d = 0:dd:(N-1)*dd;                                                          
A = exp(1j.*2*pi*d.'*sind(theta));    
S = randn(M,K) + 1j.*randn(M,K);                                            
X = A*S;                                                                    
X1 = awgn(X,snr,'measured'); 
[SP] = deal(zeros(181,1));
scale = -90:90;
index = 1;
for angle_degree = scale
    a =exp(-1j.*2*pi*d*sind(angle_degree));           
    SP(index) = (a*A).';                                     
    index = index + 1;
end
SP = (SP-min(SP))./(max(SP)-min(SP));
SP_db = db(SP);                                                           
figure(1)
subplot(111);plot(scale,SP_db,'linewidth',1);set(gca, 'Xtick',-90:15:90);
xlabel('入射角/(degree)');ylabel('空间谱/(dB)');ylim=([0,-20]);
grid on;title('CBF DOA估计');box on;                