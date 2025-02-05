clear;clc;

A=[0,1;0,0];
B=[0;1];
g=-1;
h=1;

% D is chosen as -10<x_1<10 -10<x_2<10 
x0=[10;10]
syms x1 x2 real;
L=[-1;-1.5];
EL=L'*[x1;x2];
EL
