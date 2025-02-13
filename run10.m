clear;clc;

A=[1,2;-3,-4];
B=[0;1];
C=[1,0];

% Q=eye(2);
% R=1;

% H=@(A,B,C,Q,R,k)[A+k*B*C,zeros(2,2);
% -(Q+k*k*C'*R*C),-(A+k*B*C)'];

% Ksb=-lqr(A,B,Q,R);
% lambda=eig(A+B*Ksb);

% syms k real;
% T=lambda(1)*eye(2)-(A+k*B*C);
% Td=RowOp(T,true)
% row1=Td(1,:);

% w=randn(size(row1));

% coef=dot(row1,w)/sum(row1.^2);
% w=real(w-coef*row1);


% H(A,B,C,Q,R,k)

% eigenstructure assignment
Rdes=eye(2);
lambdas=[-2,-3];
lambda=lambdas(1);
H=[lambda*eye(2)-A B*C];
V=null(H);
X1=V(1:2,:);
Y1=V(3:4,:);

n1=pinv(X1)*Rdes(:,1);
R1=X1*n1;

n1

syms lambda real;
(lambda*eye(2)-A)*R1=
