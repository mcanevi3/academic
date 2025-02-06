clear;clc;

A=[0,1;0,0];
B=[0;1];
C=[1,0];
g=-1;
h=1;

% D is chosen as -10<x_1<10 -10<x_2<10 
syms x1 x2 real;
L=[-1;-1.5];
EL=L'*[x1;x2];
EL

Q=diag([10,1]);
R=5e5;

L=-lqr(A,B,Q,R);
Ts=ss(A+B*L,B,L,0);

figure(1);clf;hold on;grid minor;
xlabel("time");title("Control signal for initial conditions");
legend("show")

x0=[10;10];
[y,t]=initial(Ts,x0);
plot(t,y,'LineWidth',2,'DisplayName',num2str(x0'));

x0=[-10;10];
[y,t]=initial(Ts,x0);
plot(t,y,'LineWidth',2,'DisplayName',num2str(x0'));

x0=[10;-10];
[y,t]=initial(Ts,x0);
plot(t,y,'LineWidth',2,'DisplayName',num2str(x0'));

x0=[-10;-10];
[y,t]=initial(Ts,x0);
plot(t,y,'LineWidth',2,'DisplayName',num2str(x0'));

print("plot1.png","-dpng","-r150")

% tvec=0:0.1:100;
% sys=ss(A,B,eye(2),zeros(2,1));

% figure(2);clf;hold on;grid minor;
% xlabel("x_1");xlabel("x_2");title("Phase portrait");
% for x0_1=-1000:100:1000
%     for x0_2=-1000:100:1000
%         [x,t]=initial(sys,[x0_1,x0_2]);
%         plot(x(1,:),x(2,:),'k');
%         drawnow;
%     end
% end
sympref("FloatingPointOutput",true);
syms t;
Phi=expm((A+B*L)*t);
Phi=simplify(rewrite(Phi,"sin"));
disp("(1,1)")
disp(Phi(1,1),3)
disp(fliplr(coeffs(Phi(1,1))))
disp("(1,2)")
disp(Phi(1,2),3)
disp(fliplr(coeffs(Phi(1,2))))

disp("(2,1)")
disp(Phi(2,1),3)
disp(fliplr(coeffs(Phi(2,1))))
disp("(2,2)")
disp(Phi(2,2),3)
disp(fliplr(coeffs(Phi(2,2))))

syms x10 x20 real
xt=Phi*[x10;x20];
ut=L*xt;
ut=simplify(rewrite(ut,"sin"));
disp("u:")

temp=subs(ut,x20,0);
disp(vpa(temp,4))
disp(fliplr(coeffs(temp)))

temp=subs(ut,x10,0);
disp(vpa(temp,4))
disp(fliplr(coeffs(temp)))
