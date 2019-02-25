% Kodskelett till l�sningar p� f�rberedelseuppgifter
% Laboration: "Robust reglerdesign av JAS 39 Gripen"

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definitioner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = tf('s');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% L�s!

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 0.3;
k = 1;

G = k/(1+T*s);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definitioner av S, T och Gwu, se kap. 6.1 i l�roboken.
% feedback(A,B) ger �verf�ringsmatrisen (I+A*B)^(-1)*A. Vad skall A, B vara
% f�r S, T och Gwu?
% Det kan vara bra att anv�nda "minreal".

G  = eye(3)/s; % dummy
Fy = eye(3); % dummy

S = minreal(feedback(eye(3),G*Fy));
T = minreal(feedback(G*Fy,eye(3)));
Gwu = minreal(-feedback(Fy,G));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% G�r f�r hand! (Detta �r en omfattande uppgift som tar tid.)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %--------------- a) --------------------
% F�rbered figurer f�r de kombinationer av a,b,c som anges i uppgiften.

% ---------------- Fallet c = 1, a > b: -------------------
W1 = W_help(1,2,1,1);
figure(51)
bodemag(W1)
title('c = 1, a > b')


% ---------------- Fallet c= 1, a < b: --------------------
W2 = W_help(1,1,2,1);
figure(52)
bodemag(W2)
title('c= 1, a < b')

% ---------------- Fallet a = inf: ------------------------
W3 = W_help(1,inf,2*pi*3,10^(3/20));
figure(53)
bodemag(W3)
title('a = inf')
%l�gpassfilter, wc=b
    
% ---------------- Fallet c = 0:   ------------------------
W4 = W_help(10^(3/20),2*pi*3,2*pi*3,0);
figure(54)
bodemag(W4)
title('c = 0')
%h�gpassfilter, wc=b

% Observera: Var hamnar brytpunkterna? Vad �r f�rst�rkningen d� w->0 resp.
% w->infty ?

%   s/a + c
% k -------
%   s/b + 1

% wc=b=2*pi*fc
% f�rst�rkningen = k*c d� w->0
% f�rst�rkningen = k*b/a d� w->inf

% %--------------- b) --------------------
H = W3*W4;
figure(55)
bodemag(H)
title('Bandpassfilter centrerat kring 3 Hz')
dB=20*log10(freqresp(H,2*pi*3))

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %--------------- a) --------------------
G  = [1/(s+1),1/((s+1)*(s+4));1/(s+3),1/((s+1)*(s+5))];
dim_u = size(G,2); % Antalet kolonner �r antalet inputs
Fy_a = eye(dim_u);

% Best�m k�nslighetsfunktionerna, se uppg. 3.
S_a = minreal(feedback(eye(2),G*Fy_a));
T_a = minreal(feedback(G*Fy_a,eye(2)));
Gwu_a = minreal(-feedback(Fy_a,G));

% %--------------- b) --------------------
WT_b  = [s/(0.3*s+1),0;0,s/(0.3*s+1)];
WS  = [1/(2*s+1),0;0,1/(2*s+1)];
WU  = [s/(3*s+1),0;0,s/(3*s+1)];

% % Se avsnitt 4 i labb-pm f�r hur Fy kan best�mmas med kommandot hinfsyn.

G0_b=minreal([zeros(2,2) WU;zeros(2,2) WT_b*G; WS WS*G;eye(2) G]);
Fy_b = hinfsyn(G0_b,2,2,'GMIN',0.1,'GMAX',100,'TOLGAM',0.01);
Fy_b = -Fy_b;

% Best�m k�nslighetsfunktionerna.
S_b = minreal(feedback(eye(2),G*Fy_b));
T_b = minreal(feedback(G*Fy_b,eye(2)));
Gwu_b = minreal(-feedback(Fy_b,G));

%--------------- c) --------------------
WT_c  = [10*(s+1)/(0.3*s+1),0;0,10*(s+1)/(0.3*s+1)];

% Best�m Fy
G0_c=minreal([zeros(2,2) WU;zeros(2,2) WT_c*G; WS WS*G;eye(2) G]);
Fy_c = hinfsyn(G0_c,2,2,'GMIN',0.1,'GMAX',100,'TOLGAM',0.01);
Fy_c = -Fy_c;

% Best�m k�nslighetsfunktionerna.
S_c = minreal(feedback(eye(2),G*Fy_c));
T_c = minreal(feedback(G*Fy_c,eye(2)));
Gwu_c = minreal(-feedback(Fy_c,G));

%--------------------------------------
% J�mf�r resultat
figure(61)
sigma(S_a,S_b,S_c)
legend('a','b','c','location','southeast')
title('S')

figure(62)
sigma(T_a,T_b,T_c)
legend('a','b','c','location','southeast')
title('T')

figure(63)
sigma(Gwu_a,Gwu_b,Gwu_c)
legend('a','b','c','location','southeast')
title('Gwu')

% figure(64)
% subplot(1,3,1)
% sigma(G*Fy_a)
% title('G*Fy_a=G')
% 
% subplot(1,3,2)
% sigma(Fy_b)
% title('Fy_b')
% 
% subplot(1,3,3)
% sigma(G*Fy_b)
% title('G*Fy_b')

% figure(65)
% subplot(1,2,1)
% sigma(WT_b)
% title('WT_b')
% 
% subplot(1,2,2)
% sigma(WT_c)
% title('WT_c')

% figure(66)
% subplot(1,2,1)
% sigma(Fy_b)
% title('Fy_b')
% 
% subplot(1,2,2)
% sigma(Fy_c)
% title('Fy_c')

%S a-b) |S| s�mre i b �n a
%T a-b) |T| b�ttre i b �n a
%Gwu a-b) |Gwu| s�mre i b �n a f�r sm� w och |Gwu| b�ttre i b �n a f�r
%st�rre w

%WT_b-WT_c) |WT_c|>|WT_b| f�r alla w! => b�ttre T!

%T_c) Fy_c p�verkar T_c v�ldigt positivt, dvs. g�r T_c liten!
%S_c) Fy_c p�verkar S_c  negativt, dvs. tvingar S_c att vara st�rre,
%j�mf�rt med i b, iaf f�r l�gre frekvenser, vilket �ven �r d�r S beh�ver
%vara liten, detta eftersom S+T=I!!

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Detta �r en omfattande uppgift som tar l�ng tid. Konstruera
% diagonalelementen till WS, WT och WU som l�gpass/h�gpass/bandpass filter
% t.ex. med hj�lpfunktionen W_help.

%WU 2x2, WT 3x3, WS 3x3

%   s/a + c
% k -------
%   s/b + 1

% wc=b=2*pi*fc
% f�rst�rkningen = k*c d� w->0
% f�rst�rkningen = k*b/a d� w->inf

%figure(70)
W1_S_betha=W_help(1,inf,1,10^(6/20));
%bodemag(W1_S_betha)

%figure(71)
W2_S_p=W_help(1,inf,3,10^(8/20));
%bodemag(W2_S_p)

%figure(72)
W3_S_r=W_help(10^((5/2+3)/20),3,3,0)*W_help(1,inf,3,10^((5/2+3)/20));
%bodemag(W3_S_r)

WS = [W1_S_betha,0,0;0,W2_S_p,0;0,0,W3_S_r];

%figure(73)
W1_T = W_help(0.3,40,40,0);
%bodemag(W1_T)

% figure(74)
% p0=100;
% dG=s/(s+p0);
% bodemag(0.3*dG,W1_T)
% legend('0.3dG','W1_T')

WT = [W1_T,0,0;0,W1_T,0;0,0,W1_T];

%figure(75)
W1_U = W_help(1/3*10^(3/20),2*pi*4,2*pi*4,0);
%bodemag(W1_U)

WU = [W1_U,0;0,W1_U];

figure(76)
sigma(WS,WT,WU)
legend('WS','WT','WU')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se tips i kompendiet.
G_tilde=minreal(feedback(G(1:2,1:2),Fy(1:2,1:2)));
Fr0=pinv(dcgain(G_tilde));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gc = G_tilde*Fr;


