clc
clear all
close all

data = importdata('test.dat');
tempo = data(:,1);
velocidade = data(:,2);
alpha = data(:,3);
beta = data(:,4);
phi = data(:,5);
teta = data(:,6);
psi = data(:,7);
P = data(:,8);
Q = data(:,9);
R = data(:,10);
Altitude = data(:,11);
deflexao_aileron_direito = data(:,12);
deflexao_aileron_esquerdo = data(:,13);
deflexao_do_profundor = data(:,14);
deflexao_do_leme = data(:,15);
forca_de_arrasto = data(:,16);
forca_de_sustentacao = data(:,17);
forca_lateral = data(:,18);
forca_de_tracao = data(:,19);
momento_de_rolamento = data(:,20);
momento_de_arfagem = data(:,21);
momento_de_guinada = data(:,22);
wing_span = data(:,23);
u = data(:,24);
v = data(:,25);
w = data(:,26);

%% ---------------- plot de velocidade ----------------%%
plot(tempo,velocidade);
title('tempo x velocidade');
xlabel('tempo (s)')
ylabel('velocidade (ft/s)')
figure

%% ---------------- plot de angulos ----------------%%
subplot(2,1,1)
plot(tempo,alpha)
title('tempo x Angulo de ataque')
xlabel('tempo (s)')
ylabel('�ngulo (graus)')

subplot(2,1,2)
plot(tempo,beta)
title('tempo x Angulo de derrapagem')
xlabel('tempo (s)')
ylabel('�ngulo (graus)')

figure
subplot(3,1,1)
plot(tempo,phi)
title('tempo x Angulo de rolamento')
xlabel('tempo (s)')
ylabel('�ngulo (graus)')


subplot(3,1,2)
plot(tempo,teta)
title('tempo x Angulo de arfagem')
xlabel('tempo (s)')
ylabel('�ngulo (graus)')

subplot(3,1,3)
plot(tempo,psi)
title('tempo x Angulo de guinada')
xlabel('tempo (s)')
ylabel('�ngulo (graus)')

%% ---------------- plot de velocidades angulares ----------------%%

figure
subplot(3,1,1)
plot(tempo,P)
title('tempo x P')
xlabel('tempo (s)')
ylabel('P (rad/s)')

subplot(3,1,2)
plot(tempo,Q)
title('tempo x Q')
xlabel('tempo (s)')
ylabel('Q (rad/s)')

subplot(3,1,3)
plot(tempo,R)
title('tempo x R')
xlabel('tempo (s)')
ylabel('R (rad/s)')

%% ---------------- plot de altitude ----------------%%

figure
plot(tempo,Altitude)
title('tempo x Altitude')
xlabel('tempo (s)')
ylabel('altitude (ft)')

%% ---------------- plot de deflexao de ailerons ----------------%%

figure
subplot(2,1,1)
plot(tempo,deflexao_aileron_direito)
title('tempo x deflexao de aileron direito')
xlabel('tempo (s)')
ylabel('deflexao (graus)')

subplot(2,1,2)
plot(tempo,deflexao_aileron_esquerdo)
title('tempo x deflexao de aileron esquerdo')
xlabel('tempo (s)')
ylabel('deflexao (graus)')

%% ---------------- plot de deflexao de leme e profundor ----------------%%
figure
subplot(2,1,1)
plot(tempo,deflexao_do_leme)
title('tempo x deflexao do leme')
xlabel('tempo (s)')
ylabel('deflexao (graus)')

subplot(2,1,2)
plot(tempo,deflexao_do_profundor)
title('tempo x deflexao do profundor')
xlabel('tempo (s)')
ylabel('deflexao (garus)')

%% ---------------- plot de for�as ----------------%%
figure
subplot(4,1,1)
plot(tempo,forca_de_arrasto)
title('tempo x for�a de arrasto')
xlabel('tempo (s)')
ylabel('For�a (lbs)')

subplot(4,1,2)
plot(tempo,forca_de_sustentacao)
title('tempo x for�a de sustenta��o')
xlabel('tempo (s)')
ylabel('For�a (lbs)')

subplot(4,1,3)
plot(tempo,forca_lateral)
title('tempo x for�a lateral')
xlabel('tempo (s)')
ylabel('For�a (lbs)')

subplot(4,1,4)
plot(tempo,forca_de_tracao)
title('tempo x for�a de tra��o')
xlabel('tempo (s)')
ylabel('For�a (lbs)')

%% ---------------- plot de Momentos ----------------%%
figure
subplot(3,1,1)
plot(tempo,momento_de_arfagem)
title('tempo x momento de arfagem')
xlabel('tempo (s)')
ylabel('Momento (lbsft)')

subplot(3,1,2)
plot(tempo,momento_de_guinada)
title('tempo x momento de guinada')
xlabel('tempo (s)')
ylabel('Momento (lbsft)')

subplot(3,1,3)
plot(tempo,momento_de_rolamento)
title('tempo x momento de rolamento')
xlabel('tempo(s)')
ylabel('Momento (lbsft)')

%% ---------------- plot de u,v e w ----------------%%
figure
subplot(3,1,1)
plot(tempo,u)
title('tempo x u')
xlabel('tempo (s)')
ylabel('u')

subplot(3,1,2)
plot(tempo,v)
title('tempo x v')
xlabel('tempo (s)')
ylabel('v')

subplot(3,1,3)
plot(tempo,w)
title('tempo x w')
xlabel('tempo(s)')
ylabel('w')