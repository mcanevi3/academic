clear;clc;
% n=2 m=1 
syms a1 a2 a3 a4 real
syms b1 b2 real
A=[a1,a2;a3,a4];
B=[b1;b2];

syms g h real
% g<u<h
syms l11 l12 real
l1=[l11;l12];
L=l1;

Ac=A+B*L';

syms z11 z12 real;
z=[z11;z12];
disp(string(g)+"<"+string(l1'*z)+"<"+string(h))
