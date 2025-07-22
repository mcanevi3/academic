% LQR Control Example
% This script sets up a Linear Quadratic Regulator (LQR) problem with given system
% matrices and computes the optimal gain matrix.
clear;clc;

% a good example for better PID-like LQR control
Gs=tf(1,[1,2*0.01*1,1^2]);
Q=diag([1,1]);
R=0.1;

% another test example
% Gs=tf(1,conv([1,0.01],[1,0.01,5]));
% Q=diag([1,1,1]);
% R=1;

tfinal=20;
Qq=10;
Qs=10;
tau=inv(100);

[A,B,C,D]=ssdata(Gs);
n=size(A,1);
m=size(B,2);

% Regular LQR
K=-lqr(A,B,Q,R);
Ts=ss(A+B*K,B,C,D);
Ts1=tf(Ts);
Tu1=tf(ss(A+B*K,B,K,0));

% Integral LQR
Q_aug=blkdiag(Q,Qq);
A_aug = [A, zeros(n,1); -C, 0];
B_aug = [B; -D];
B_r=[zeros(n,1);1];
C_aug=[C,0];
K_aug = -lqr(A_aug, B_aug, Q_aug, R);
Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
Ts2=tf(Ts);
Tu2=tf(ss(A_aug+B_aug*K_aug,B_r,K_aug,0));

% PI+Filter LQR
Q_aug = blkdiag(Q,Qs,Qq);
A_aug = [A, zeros(n,1),zeros(n,1); -inv(tau)*C, -inv(tau),0; -C, 0, 0];
B_aug = [B; -inv(tau)*D;-D];
B_r=[zeros(n,1);inv(tau);1];
C_aug= [C, 0, 0];
K_aug = -lqr(A_aug, B_aug, Q_aug, R);
Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
Ts3=tf(Ts);
Tu3=tf(ss(A_aug+B_aug*K_aug,B_r,K_aug,0));

figure(1);clf;
subplot(1,2,1);cla;hold on;grid on;
xlabel("Time (s)");ylabel("Amplitude");title("LQR Control");
legend('show');
[y1,t1]=step(Ts1,tfinal);
[y2,t2]=step(Ts2,tfinal);
[y3,t3]=step(Ts3,tfinal);
plot(t1,y1,'b','LineWidth',2,'DisplayName','Regular LQR');
plot(t2,y2,'r--','LineWidth',2,'DisplayName','Integral LQR');
plot(t3,y3,'k-.','LineWidth',2,'DisplayName','PID-like LQR');

subplot(1,2,2);cla;hold on;grid on;
xlabel("Time (s)");ylabel("Amplitude");title("Control Signals");
legend('show');
[y1,t1]=step(Tu1,tfinal);
[y2,t2]=step(Tu2,tfinal);
[y3,t3]=step(Tu3,tfinal);
plot(t1,y1,'b','LineWidth',2,'DisplayName','Regular LQR');
plot(t2,y2,'r--','LineWidth',2,'DisplayName','Integral LQR');
plot(t3,y3,'k-.','LineWidth',2,'DisplayName','PID-like LQR');