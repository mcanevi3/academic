clear;clc;

clear;clc;

Gs=tf(1,[1,2*0.01*1,1^2]);
Q=diag([1,1]);
R=1e-3;

tau=inv(100);

[A,B,C,D]=ssdata(Gs);
n=size(A,1);
m=size(B,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qsvec=logspace(-1,2,50);

[Qqmat,Qsmat]=meshgrid(qsvec,qsvec);
os=nan(size(Qqmat));
ts=nan(size(Qqmat));
os_new=nan(size(Qqmat));
ts_new=nan(size(Qqmat));
for i=1:length(qsvec)
    for j=1:length(qsvec)
        Qq=Qqmat(i,j);
        Qs=Qsmat(i,j);
        
        % PI LQR
        Q_aug=blkdiag(Q,Qq);
        A_aug = [A, zeros(n,1); -C, 0];
        B_aug = [B; -D];
        B_r=[zeros(n,1);1];
        C_aug=[C,0];
        K_aug = -lqr(A_aug, B_aug, Q_aug, R);
        Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
        Ts=tf(Ts);
        info=stepinfo(Ts);
        os(i,j)=info.Overshoot;
        ts(i,j)=info.SettlingTime;

        % PI+Filter LQR
        A_aug = [A, zeros(n,1),zeros(n,1); -inv(tau)*C, -inv(tau),0; -C, 0, 0];
        B_aug = [B; -inv(tau)*D;-D];
        B_r=[zeros(n,1);inv(tau);1];
        C_aug= [C, 0, 0];
        
        Q_aug =blkdiag(Q,Qs,Qq); 
        K_aug = -lqr(A_aug, B_aug, Q_aug, R);
        Ts=ss(A_aug+B_aug*K_aug,B_r,C_aug,D);
        Ts=tf(Ts);
        info=stepinfo(Ts);
        os_new(i,j)=info.Overshoot;
        ts_new(i,j)=info.SettlingTime;
    end
end

figure(1);clf;hold on;grid on;
xlabel("Qs");ylabel("Overshoot (%)");legend('show');
set(gca,'XScale','log');
title("Overshoot vs Qs");
surf(qsvec,qsvec,os,'FaceColor','b','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Overshoot');
surf(qsvec,qsvec,os_new,'FaceColor','r','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Overshoot (PI+Filter)');

figure(2);clf;hold on;grid on;
xlabel("Qs");ylabel("Settling Time (s)");legend('show');
set(gca,'XScale','log');
title("Settling Time vs Qs");
surf(qsvec,qsvec,ts,'FaceColor','b','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Settling Time');
surf(qsvec,qsvec,ts_new,'FaceColor','r','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Settling Time (PI+Filter)');

tsmax=max(ts(:));
ts_new_max=max(ts_new(:));
tsupper=max(tsmax,ts_new_max);

osmax=max(os(:));
os_new_max=max(os_new(:));
osupper=max(osmax,os_new_max);

alpha1=0.1;
alpha2=1-alpha1;
cost=alpha1*(ts-tsupper)/tsupper + alpha2*(os-osupper)/osupper;
cost_new=alpha1*(ts_new-tsupper)/tsupper + alpha2*(os_new-osupper)/osupper;


figure(3);clf;hold on;grid on;
xlabel("Qs");ylabel("Cost");legend('show');
set(gca,'XScale','log');
title("Cost vs Qs");
surf(qsvec,qsvec,cost,'FaceColor','b','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Cost');
surf(qsvec,qsvec,cost_new,'FaceColor','r','FaceAlpha',0.85,'EdgeColor','k','DisplayName','Cost (PI+Filter)');
