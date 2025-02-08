clear;clc;
% Eigenstructure assignment
A=[1,-1,0;0,-1,2;2,1,-2];
% B=[0,1,0;-1,0,1;1,1,1];
B=[0;0;1];
gammavec=[-1+1i,-1-1i,-5];
[n,m]=size(B);
Rd=[[0;sqrt(2)/2;1i*sqrt(2)/2],[0;sqrt(2)/2;-1i*sqrt(2)/2],[1;0;0]];
Rd=[[0;sqrt(2)/2;-1i*sqrt(2)/2],[0;sqrt(2)/2;+1i*sqrt(2)/2],[1;0;0]];

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

    Wi=[null(QQi,"rational");null(PPi,"rational")];
    % ZWi=null(Wi);

    % ni=pinv(ZWi)*RRid
    % Rai=ZWi*ni
    Rai=RRid;
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
% end

K=-M*pinv(R)
Ac=A+B*K;

Rinv=inv(R);
syms t real;
Phi=diag(exp(gammavec*t))
x0=[1;1;1];
z0=R*x0;

Kz=K*inv(R);
Kz*z0

zt=Phi*z0;
ut=Kz*zt;
fut=matlabFunction(ut);
figure(1);clf;hold on;grid on;
tvec=0:0.01:5;
plot(tvec,fut(tvec),'LineWidth',2);

% K2=K;
% K2(K2<0)=-K2(K2<0);
% K2
% real(xt)
% imag(xt)

% coef=coeffs(ut);
% coef
% sqrt(sum(coef.^2))