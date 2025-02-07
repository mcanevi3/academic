clear;clc;

A=[0,1;0,0];
B=[0;1];
Q=eye(2);
R=1;

L=-lqr(A,B,Q,R);
Ac=A+B*L;
[V,D]=eig(Ac);

% inv(V)*Ac*V=Lambda
% Ac=V Lambda inv(V)
% e^Ac=e^(V Lambda inv(V))

% A+BL=T[-p1,0;0,-p2]inv(T)
% BL=
T=randn(2,2)
syms p1 p2 real;
syms l1 l2 real;
L=[l1 l2];
prob=B*L==(T*[-p1,0;0,-p2]*inv(T)-A)
sol=solve(prob)

syms a b real;


phi=[B,A*B];
coef=[1 a b];
pdA=coef(1)*A*A+coef(2)*A+coef(3)*eye(2);
L=-[0,1]*inv(phi)*pdA;
Ac=A+B*L;

A=[1,2;-3,-4];

[V,D]=eig(A);
syms p1 p2 real;
syms l1 l2 real;
theta=180;
V=[cosd(theta),sind(theta);
   -sind(theta),cosd(theta)];
prob=(A+B*[l1,l2])==V*diag([-p1,-p2])*pinv(V);
prob
sol=solve(prob)

% A+BL =TDT^-1
% BL =TDT^-1-A
% [l1*B l2*B]=TDT^-1-A
% [l1*B l2*B]=SMS^-1
syms b1 b2 real;
B=[b1;b2];
L=[l1,l2];
[V,D]=eig(B*L)
temp=inv(V)*(B*L)*V;
simplify(temp)
% A*B  share eigenvectors then they commute

% z=Tx
% x=T^{-1}z

% T^{-1}z'=AT^{-1}z+Bu
% TT^{-1}z'=TAT^{-1}z+TBu
% z'=TAT^{-1}z+TBu

% T=inv(V)