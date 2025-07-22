clear;clc;

clear;clc;

Gs=tf(1,[1,2*0.01*1,1^2]);
Q=diag([1,1]);
R=1e-3;

Qq=10;
tau=inv(100);


[A,B,C,D]=ssdata(Gs);
n=size(A,1);
m=size(B,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Integral LQR
Q_aug=blkdiag(Q,Qq);
A_aug = [A, zeros(n,1); -C, 0];
B_aug = [B; -D];
B_r=[zeros(n,1);1];
C_aug=[C,0];
K_aug = -lqr(A_aug, B_aug, Q_aug, R);
Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
Ts0=tf(Ts);
info=stepinfo(Ts0);
os0=info.Overshoot;
ts0=info.SettlingTime;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A_aug = [A, zeros(n,1),zeros(n,1); -inv(tau)*C, -inv(tau),0; -C, 0, 0];
B_aug = [B; -inv(tau)*D;-D];
B_r=[zeros(n,1);inv(tau);1];
C_aug= [C, 0, 0];

qsvec=logspace(-4,2,50);
os=zeros(size(qsvec));
ts=zeros(size(qsvec));
for i=1:length(qsvec)
    Qs=qsvec(i);
    Q_aug =blkdiag(Q,Qs,Qq); 

    K_aug = -lqr(A_aug, B_aug, Q_aug, R);
    Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
    Ts=tf(Ts);
    info=stepinfo(Ts);
    os(i)=info.Overshoot;
    ts(i)=info.SettlingTime;
end

figure(1);clf;hold on;grid on;
xlabel("Qs");ylabel("Overshoot (%), Settling Time (s)");legend('show');
% set(gca,'XScale','log');
title("Overshoot vs Qs");
plot(qsvec,os0*ones(size(qsvec)),'b--','LineWidth',2,'DisplayName',num2str(os0));
plot(qsvec,os,'b','LineWidth',2,'DisplayName','Overshoot');
plot(qsvec,ts0*ones(size(qsvec)),'r--','LineWidth',2,'DisplayName',num2str(ts0));
plot(qsvec,ts,'r','LineWidth',2,'DisplayName','Settling Time');

