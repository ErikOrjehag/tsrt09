
addpath /courses/tsrt09/exercises/;

%%
g=[0.7 0.7];
u0=[3 3];
x0=statpoint(u0,[],g);
[A,B,C,D]=tanklin(x0,g);
s=ss(A,B,C,D);

%%
pole(s)
zero(s)
figure(99); sigma(s)

G0=freqresp(s, 0);
RGA0=G0.*(transpose(inv(G0)))

Q1=eye(2);
Q2=eye(2);

[L,S,E]=lqr(s, C'*Q1*C, Q2, []);

L0=inv(C * inv(B * L - A) * B);
%%

r1 = 0.01 % systembrus
r2 = 0.1 % mätbrus
%K=place(A', C', -0.04*[1 1.01 1.02 1.03])';

K=lqe(A,B,C,r1*eye(2,2),r2*eye(2,2),zeros(2,2));

