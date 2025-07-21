% LQR Control Example
% This script sets up a Linear Quadratic Regulator (LQR) problem with given system
% matrices and computes the optimal gain matrix.
clear;clc;

% a good example for better PID-like LQR control
% Gs=tf(1,[1,0.01,5]);
% Q=diag([1,1]);
% R=1;

% another test example
Gs=tf(1,conv([1,0.01],[1,0.01,5]));
Q=diag([1,1,1]);
R=0.1;


[A,B,C,D]=ssdata(Gs);
n=size(A,1);
m=size(B,2);

% Regular LQR
K=-lqr(A,B,Q,R);
Ts=ss(A+B*K,B,C,D);
Ts1=tf(Ts);

% Integral LQR
Q_aug=blkdiag(Q,10);
A_aug = [A, zeros(n,1); -C, 0];
B_aug = [B; -D];
B_r=[zeros(n,1);1];
C_aug=[C,0];
K_aug = -lqr(A_aug, B_aug, Q_aug, R);
Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
Ts2=tf(Ts);

% PID-like LQR
tau=1e-2;
Q_aug = blkdiag(Q,10,10);
A_aug = [A, zeros(n,1),zeros(n,1); -inv(tau)*C, -inv(tau),0; -C, 0, 0];
B_aug = [B; -inv(tau)*D;-D];
B_r=[zeros(n,1);inv(tau);1];
C_aug= [C, 0, 0];
K_aug = -lqr(A_aug, B_aug, Q_aug, R);
Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
Ts3=tf(Ts);

figure(1);clf;
subplot(1,2,1);cla;hold on;grid on;
xlabel("Time (s)");ylabel("Amplitude");title("LQR Control");
[y1,t1]=step(Ts1,10);
[y2,t2]=step(Ts2,10);
[y3,t3]=step(Ts3,10);
plot(t1,y1,'b','LineWidth',2,'DisplayName','Regular LQR');
plot(t2,y2,'r--','LineWidth',2,'DisplayName','Integral LQR');
plot(t3,y3,'k-.','LineWidth',2,'DisplayName','PID-like LQR');
legend('show');
subplot(1,2,2);cla;hold on;grid on;
[poles1,zeros1]=pzmap(Ts1);
[poles2,zeros2]=pzmap(Ts2);
[poles3,zeros3]=pzmap(Ts3);
plot(real(poles1),imag(poles1),'bx','LineWidth',4,'DisplayName','Regular LQR');
plot(real(poles2),imag(poles2),'rx','LineWidth',4,'DisplayName','Integral LQR');
plot(real(poles3),imag(poles3),'kx','LineWidth',4,'DisplayName','PID-like LQR');
plot(real(zeros1),imag(zeros1),'bo','LineWidth',4,'DisplayName','Regular LQR');
plot(real(zeros2),imag(zeros2),'ro','LineWidth',4,'DisplayName','Integral LQR');
plot(real(zeros3),imag(zeros3),'ko','LineWidth',4,'DisplayName','PID-like LQR');
xlabel("Real Part");ylabel("Imaginary Part");title("Poles and Zeros");
axis equal;grid on;
legend('show');

