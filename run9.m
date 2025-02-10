% test lqr sky-hook
clear;clc;

A=[1,2;-3,-4];
B=[0;1];
C=[1,0];

Q=eye(2);
R=0.01;

syms s;
syms k real;
Ac=A+k*B*C;
pol=det(s*eye(2)-Ac);
pol=collect(pol,s);
coef=coeffs(pol,s,'all');

syms w real;
pw=subs(pol,s,1i*w);
prob=[real(pw)==0,imag(pw)==0];
sol=solve(prob);
kval=double(sol.k);
wval=double(sol.w);
disp("k:");
disp(kval);
disp("w:");
disp(wval);

coef=coeffs(pol,k,'all');
Gs=tf(double(coeffs(coef(1),s,'all')),double(coeffs(coef(2),s,'all')))
figure(1);clf;
rlocus(Gs);

k=0.9;
H=[A+k*B*C,zeros(2,2);
-(Q+k*k*C'*R*C),-(A+k*B*C)'];
disp("Eig H:");
disp(eig(H));
Ac=A+k*B*C;

[V,D]=eig(H);
lambdas=diag(D);
index=lambdas<0;
Vp=V(:,index);
V11=Vp(1:2,:);
V21=Vp(3:4,:);
P=V21*inv(V11);


Ts=ss(A+k*B*C,B,C,0);
[y,t]=step(Ts);
figure(3);clf;hold on;grid on;
plot(t,y,'LineWidth',2);

syms k real;
H=[A+k*B*C,zeros(2,2);
-(Q+k*k*C'*R*C),-(A+k*B*C)'];
disp("Eig H:");
disp(eig(H));