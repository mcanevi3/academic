clear;clc;
A=[1,2;-3,-4];
B=[0;1];
C=[1,2];
n=size(A,1);
m=size(B,2);
I=eye(n);

slope=@(v)v(2)/v(1);

kval=-2;
lambdavec=eig(A+kval*B*C);
R=zeros(n,n);
M=zeros(m,n);
for i=1:n
    T=[lambdavec(i)*I-A B];
    V=null(T,"rational");
    Xi=V(1:n,:);
    Yi=V(n+1:end,:);
    ni=pinv(Xi)*I(:,i);
    Ri=Xi*ni;
    Mi=Yi*ni;
    R(:,i)=Ri;
    M(:,i)=Mi;
end
Ksf=-M*inv(R);

% syms x1 x2 real;
x1=lambdavec(1);
x1=-3;
% x2=lambdavec(2);
Ta1=[x1*I-A B];
% Ta2=[x2*I-A B];
Va1=null(Ta1);
% Va2=null(Ta2);

H=[C eye(m)];
Phi=null(H);

Phix=Phi(1:2,:)
Phiy=Phi(3,:)
n1=pinv(Phix)*[1;0]

% Ta1*[X1*n1;Y1*n1]
% H*[kval*X1*n1;Y1*n1]

return
% alpha=pinv(Phi)*Va1
% Phi*alpha
% Va1

% Phix=Phi(1:2,:);
% Phiy=Phi(3,:);
% alpha1=pinv(Phiy)*Va1(3);
% alpha1
% Phix*alpha1 
% Va1(1:2)
% slope(kalpha1)
% slope(alpha1)
% kalpha2=pinv(Phix)*Va2(1:2);
% alpha2=pinv(Phiy)*Va2(3);

% [kalpha1,kalpha2]
% [alpha1,alpha2]

% symvar(prob(3)==0)
% syms k real;
% pol=det(s*eye(n)-(A+k*B*C));
% coef=coeffs(pol,k,'all');
% num=double(coeffs(coef(1),s,'all'));
% den=double(coeffs(coef(2),s,'all'));
% Gs=tf(num,den);
% figure(1);clf;
% rlocus(Gs);
