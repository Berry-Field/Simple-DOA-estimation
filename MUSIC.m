%/* File Info 
 %* Author:      Jia HB 
 %* CreateTime:  2021/3/16下午8:56:27 
 %* LastEditor:  Jia HB 
 %* ModifyTime:  2021/7/8下午3:15:21 
 %* Description: 
%*/ 
clc; clear; close all;
N = 8;                     
M = 3;                                                                     
theta = [-10 0 15];                                                         
snr = 10;                                                                   
K = 1024;  
dd = 0.5;                               
d = 0:dd:(N-1)*dd;                                                          
A = exp(1j.*2*pi*d.'*sind(theta));    
S = randn(M,K) + 1j.*randn(M,K);                                            
X = A*S;                                                                    
X1 = awgn(X,snr,'measured');   
Rxx = X1*X1'/K;                                                            
[EV,D] = eig(Rxx);                                                         
index = 1;
[SP] = deal(zeros(181,1));
scale = -90:90;
for angle_degree = scale
    a =exp(1j.*2*pi*d*sind(angle_degree)).';           
    En = EV(:,1:end-M);                                
    SP(index) = 1/abs((a'*En)*(En'*a));                                       

    index = index + 1;
end
SP_db = db(SP);                                                           

figure(1)
subplot(111);plot(scale,SP_db,'linewidth',1);set(gca, 'Xtick',-90:15:90)
xlabel('入射角/(degree)');ylabel('空间谱/(dB)');
grid on;title('MUSIC DOA估计');box on;                                                                     
