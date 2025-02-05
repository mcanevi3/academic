clear;clc;
% n=2 m=1 
syms a11 a12 a21 a22 real
syms b11 b21 real
A=[a11,a12;a21,a22];
B=[b11;b21];

syms g h real
syms l11 l21 real
l1=[l11;l21];
L=l1;

Ac=A+B*L';
Ac

syms z11 z12 real;
z=[z11;z12];
disp(string(g)+"<"+string(l1'*z)+"<"+string(h))
