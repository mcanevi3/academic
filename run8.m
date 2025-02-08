clear;clc;

A=[0,1;0,0];
A=[0,1;-2,-3];
B=[0;1];

Q=eye(2);
R=1;

Z=[A,-B*inv(R)*B';-Q,-A'];
syms s;
pol=det(s*eye(4)-Z);
[V,D]=eig(Z);
Vp=V(:,1:2);
V11=Vp(1:2,:);
V21=Vp(3:4,:);
P=V21*inv(V11)
K=-inv(R)*B'*P
Ac=A+B*K

Klqr=-lqr(A,B,Q,R)