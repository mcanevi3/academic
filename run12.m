clear;clc;

A=[1,2;-3,-4];
B=[0;1];
C=[1,0];

Rdes=eye(2);
e1=Rdes(:,1);
e2=Rdes(:,2);

syms lambda1 lambda2 real;
H=[lambda1*eye(2)-A B*C];
V=null(H);
X1=V(1:2,:);
Y1=V(3:4,:);

H=[lambda2*eye(2)-A B*C];
V=null(H);
X2=V(1:2,:);
Y2=V(3:4,:);

n1=pinv(X1)*e2;
R1=X1*n1;
M1=Y1*n1;

n2=pinv(X2)*e1;
R2=X2*n2;
M2=Y2*n2;

temp1=[-Y1*n1,X2*n2];
temp2=[-Y2*n2,X1*n1];

pol1=det(temp1);
pol2=det(temp2);

temp=pol1-pol2;
[num,den]=numden(temp);
factor(num)


fun=@(lambda1)(lambda1+5)./(lambda1-1);
lambda1vec=-(0.1:0.1:60);
figure(1);clf;hold on;grid on;
xlabel("\lambda_1");
ylabel("\lambda_2");
title("Feasible set")

lambda2vec=fun(lambda1vec);
plot(lambda1vec,lambda2vec,'k','LineWidth',2);
index=lambda2vec<0;
lambda2vec_stable=lambda2vec(index);
lambda1vec_stable=lambda1vec(index);
plot(lambda1vec_stable,lambda2vec_stable,'r','LineWidth',2);

i=1;
lambda1=lambda1vec_stable(i);
lambda2=lambda2vec_stable(i);

