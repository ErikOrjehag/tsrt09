
addpath /courses/tsrt09/exercises/;

%% 9
g=[0.3 0.3];
u0=[3 3];
x0=statpoint(u0,[],g);
[A,B,C,D]=tanklin(x0,g);
s=ss(A,B,C,D);
pole(s)
zero(s)
figure(99); sigma(s)

G0=freqresp(s, 0);
RGA0=G0.*(transpose(inv(G0)))

Q1=eye(2)*100;
Q2=eye(2);

[L,S,E]=lqr(s, C'*Q1*C, Q2, []);

L0=inv(C * inv(B * L - A) * B);

% u0->y0, u1->y1