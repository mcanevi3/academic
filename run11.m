clear;clc;

A=[1,2;-3,-4];
B=[0;1];
C=[1,0];

k=0.5;
Ac=A+B*C*k;
lambdas=eig(Ac);
Rdes=eye(2);

M=[];
R=[];

X1vec=[];
Y1vec=[];
n1vec=[];
for i=1:2
    lambda=lambdas(i)
    H=[lambda*eye(2)-A B*C]
    V=null(H);
    X1=V(1:2,:);
    Y1=V(3:4,:);
    
    n1=pinv(X1)*Rdes(:,i);

    X1vec=[X1vec,X1];
    Y1vec=[Y1vec,Y1];
    n1vec=[n1vec,n1];

    R1=X1*n1;
    R=[R,R1];
    M1=Y1*n1;
    M=[M,M1];
end
M*inv(R)

Y1vec(:,1:2)*n1vec(:,1)+k*C'*C*X1vec(:,1:2)*n1vec(:,1)
Y1vec(:,3:4)*n1vec(:,2)+k*C'*C*X1vec(:,3:4)*n1vec(:,2)

Y1vec(:,1:2)*n1vec(:,1)+k*C'*C*X1vec(:,1:2)*n1vec(:,1)

% lambda=lambdas(1);
% H=[lambda*eye(2)-A B*C];
% syms v1 v2 v3 v4 v5 v6 v7 v8 real;
% V=[v1,v2;v3,v4;v5,v6;v7,v8];
% prob=H*V==0;
% disp(prob)
% sol=solve(prob);
% Vval=subs(V,sol);

% X1=Vval(1:2,:);
% Y1=Vval(3:4,:);

% Vval2=double(subs(Vval,[v1,v2,v3,v4,v5,v6,v7,v8],[1,2,3,4,5,6,7,8]));
% X1=Vval2(1:2,:);
% Y1=Vval2(3:4,:);

% n1=pinv(X1)*Rdes(:,1);
% R1=X1*n1;
% M1=Y1*n1;

% R=[];
% M=[];

% R=[R,R1];
% M=[M,M1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lambda=lambdas(2);
% H=[lambda*eye(2)-A B*C];
% syms v1 v2 v3 v4 v5 v6 v7 v8 real;
% V=[v1,v2;v3,v4;v5,v6;v7,v8];
% prob=H*V==0;
% disp(prob)
% sol=solve(prob);
% Vval=subs(V,sol);

% X1=Vval(1:2,:);
% Y1=Vval(3:4,:);

% Vval2=double(subs(Vval,[v1,v2,v3,v4,v5,v6,v7,v8],[1,2,3,4,5,6,7,8]));
% X1=Vval2(1:2,:);
% Y1=Vval2(3:4,:);

% n1=pinv(X1)*Rdes(:,2);
% R1=X1*n1;
% M1=Y1*n1;

% R=[R,R1];
% M=[M,M1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

