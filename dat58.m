
addpath /courses/tsrt09/exercises/;

%% 5
g=[0.3 0.3];
x=statpoint([3 3],[],g);
[A,B,C,D]=tanklin(x,g);
s=ss(A,B,C,D);
pole(s)
zero(s)
figure(99); sigma(s)
%%
g=[0.3 0.3];
x=statpoint([5 5],[],g);
[A,B,C,D]=tanklin(x,g);
s=ss(A,B,C,D);
p=pole(s)
z=zero(s)
figure(99); sigma(s)
%% 6
g=[0.5 0.5];
x=statpoint([3 3],[],g);
[A,B,C,D]=tanklin(x,g);
s=ss(A,B,C,D);
p=pole(s)
z=zero(s)
figure(99); sigma(s)
%%
g=[0.5 0.5];
u0=[3 3];
x=statpoint(u0,[],g);
[A,B,C,D]=tanklin(x,g);
s=ss(A,B,C,D);
p=pole(s)
z=zero(s)
figure(99); sigma(s)
%% 7
x0=x
g0=freqresp(s, 0)
[V,D]=eig(g0'*g0)
%% 8
g=[0.3 0.3];
[x0,u0]=statpoint([],[25 25],g);
[A,B,C,D]=tanklin(x0,g);
s=ss(A,B,C,D);
z=zero(s)
evalfr(s,z)






