clear;clc;
% Eigenstructure assignment
A=[1,-1,0;0,-1,2;2,1,-2];
B=[0,1,0;-1,0,1;1,1,1];
B=[0;0;1];
gammavec=[-7,-2,-1];
[n,m]=size(B);
Rd=eye(n);
Rd=Rd(:,[3,1,2]);
Rd

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

R*diag(exp(gammavec))*inv(R)
expm(Ac)


