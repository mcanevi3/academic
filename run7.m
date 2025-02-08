clear;clc;

ms=2.5;
mus=1;
ks=900;
kus=1250;
bs=7.5;
bus=5;

A=[
    0,1,0,-1;
    -ks/ms,-bs/ms,0,bs/ms;
    0,0,0,1;
    ks/mus,bs/mus,-kus/mus,-(bs+bus)/mus;
];
B=[0;1/ms;0;-1/mus];
% Q=diag([450 30 5 0.01]);
% R=0.01;
% K=-lqr(A,Bu,Q,R);

[n,m]=size(B);
gammavec=[-10,-14,-26,-25];
Rd=eye(n);
Rd=Rd(:,[3,1,2,4]);

M=[];
R=[];
for i=1:n
    gamma=gammavec(i);
    PR1=[gamma*eye(n)-A B];
    Z1=null(PR1,"rational");
    X1=Z1(1:n,:);
    Y1=Z1(n+1:end,:);
    n1=pinv(X1)*Rd(:,i);
    m1=Y1*n1;
    R1=X1*n1;

    M=[M,m1];
    R=[R,R1];
end

K=-M*pinv(R)
Ac=A+B*K;
eig(Ac)