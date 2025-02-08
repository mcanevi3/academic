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
gammavec=[-1+1i,-1-1i,-6,-5];
Rd=[[sqrt(2)/2;1i*sqrt(2)/2;0;0],[sqrt(2)/2;-1i*sqrt(2)/2;0;0],[0;0;1;0],[0;0;0;1]];

M=[];
R=[];
i=1;
% for i=1:n
    gamma=gammavec(i);
    PC1=[real(gamma)*eye(n)-A imag(gamma)*eye(n) B];
    Z1=null(PC1,"rational");
    Xi1=Z1(1:n,:);
    Xi2=Z1(n+1:2*n,:);
    Yi=Z1(2*n+1:end,:);
    QQi=[Xi1;-Xi2];
    PPi=[Xi2;Xi1];
    RRid=[real(Rd(:,i));imag(Rd(:,i))];

    Wi=[null(QQi',"rational"),null(PPi',"rational")]';
    ZWi=null(Wi);

    ni=pinv(ZWi)*RRid
    Rai=ZWi*ni
    mi1=Yi*pinv(QQi)*Rai;
    mi2=Yi*pinv(PPi)*Rai;
    ReRai=Rai(1:n,:);
    ImRai=Rai(n+1:end,:);
%     n1=pinv(X1)*Rd(:,i);
%     m1=Y1*n1;
%     R1=X1*n1;

    M=[M,mi1,mi2];
    R=[R,ReRai,ImRai];

    i=3;
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

    i=4;
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
% end

K=-M*pinv(R)
Ac=A+B*K;
eig(Ac)