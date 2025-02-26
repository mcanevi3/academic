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

n1=simplify(n1);
n2=simplify(n2);
temp1=Y1*n1./(C'*C*X1*n1);
temp2=Y2*n2./(C'*C*X2*n2);

% lvec=[-2.5,-2.5];
% double(subs(C'*C*X1*n1,[lambda1,lambda2],lvec))
% double(subs(Y2*n2,[lambda1,lambda2],lvec))
% double(subs(C'*C*X2*n2,[lambda1,lambda2],lvec))
% double(subs(Y1*n1,[lambda1,lambda2],lvec))


lambda1vec1=-1:-1:-10;
lambda2vec1=lambda1vec1;

index=lambda1vec1==-1 | lambda1vec1==-2;
lambda1vec1(index)=[];
lambda2vec1(index)=[];

i=1;
lambda1val=lambda1vec1(i);
lambda2val=lambda2vec1(i);

lvec=[lambda1val,lambda2val];
lvec
Kvec=-acker(A,B,lvec);
Kvec
eig(A+B*Kvec)
% lambda1vec2=-2.5:0.5:-0.5;
% lambda2vec2=-lambda1vec2-3;

% figure(1);clf;hold on;grid on;
% plot(lambda1vec1,lambda2vec1,'r','LineWidth',2);
% plot(lambda1vec2,lambda2vec2,'b','LineWidth',2);
