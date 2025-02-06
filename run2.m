clear;clc;

A=[0,1;0,0];
B=[0;1];
g=-1;
h=1;

Q=diag([1,1]);
syms r real;
R=r;

syms p1 p2 p3 real;
P=[p1,p2;p2,p3];

expr=A'*P+P*A-(P*B)*inv(R)*(P*B)'+Q;
disp("ARE:")
disp(simplify(expr*r))
sol=solve(expr,[p1,p2,p3]);

syms a b real;
syms t real;
Ac=[0,1;a,b];
Ac*Ac
Ac*Ac*Ac

Phi=eye(2)+Ac*t+(Ac*Ac)*t^2/2;%+(Ac*Ac*Ac)*t^3/6;
Phi
expm(Ac*t)