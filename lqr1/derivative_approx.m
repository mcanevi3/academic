clear;clc;

tau=1e-3;
Gs=tf([1,0],1);
Gs_approx=tf([1,0],[tau,1]);

w=logspace(-2,3,1000);
[mag,phase]=bode(Gs,w);
mag=squeeze(mag);
phase=squeeze(phase);
[mag_approx,phase_approx]=bode(Gs_approx,w);
mag_approx=squeeze(mag_approx);
phase_approx=squeeze(phase_approx);

figure(1);clf;
subplot(2,1,1);cla;hold on;grid on;set(gca,'XScale','log');
semilogx(w,20*log10(mag),'b','LineWidth',2,'DisplayName','Original System');
semilogx(w,20*log10(mag_approx),'r--','LineWidth',2,'DisplayName','Approximation');
xlabel("Frequency (rad/s)");ylabel("Magnitude (dB)");
title("Magnitude Response");
legend('show');
subplot(2,1,2);cla;hold on;grid on;set(gca,'XScale','log');
semilogx(w,phase,'b','LineWidth',2,'DisplayName','Original System');
semilogx(w,phase_approx,'r--','LineWidth',2,'DisplayName','Approximation');
xlabel("Frequency (rad/s)");ylabel("Phase (degrees)");
title("Phase Response");
legend('show');

t=0:1e-3:10;
u=sin(t);
% y=lsim(Gs,u,t);
y_approx=lsim(Gs_approx,u,t);
figure(2);clf;hold on;grid on;
plot(t,u,'k','LineWidth',2,'DisplayName','sin(t)');
plot(t,cos(t),'k--','LineWidth',2,'DisplayName','cos(t)');
plot(t,y_approx,'r--','LineWidth',2,'DisplayName','Approximate Derivative');
xlabel("Time (s)");ylabel("Output");
title("Time Response");
legend('show');
