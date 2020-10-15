clc
clear all
close all

cut = 700;
data = importdata('test.dat');
tempo = data(:,1);
tempo = tempo(cut:end);
tempo = tempo - tempo(1);
velocidade = data(:,2);
velocidade = velocidade(cut:end);
alpha = data(:,3);
alpha = alpha(cut:end);
beta = data(:,4);
beta = beta(cut:end);
phi = data(:,5);
phi = phi(cut:end);
teta = data(:,6);
teta = teta(cut:end);
psi = data(:,7);
psi = psi(cut:end);
P = data(:,8);
P = P(cut:end);
Q = data(:,9);
Q = Q(cut:end);
R = data(:,10);
R = R(cut:end);
% A altitude é dividida pelo wingspan, então depois de aquisitada é multiplicada pelo wingspan
Altitude = data(:,11)*33.83;
Altitude = Altitude(cut:end);
deflexao_aileron_direito = data(:,12);
deflexao_aileron_direito = deflexao_aileron_direito(cut:end);
deflexao_aileron_esquerdo = data(:,13);
deflexao_aileron_esquerdo = (-1)*deflexao_aileron_esquerdo(cut:end);
deflexao_do_profundor = data(:,14);
deflexao_do_profundor = deflexao_do_profundor(cut:end);
deflexao_do_leme = data(:,15);
deflexao_do_leme = deflexao_do_leme(cut:end);
forca_de_arrasto = data(:,16);
forca_de_arrasto = forca_de_arrasto(cut:end);
forca_de_sustentacao = data(:,17);
forca_de_sustentacao = forca_de_sustentacao(cut:end);
forca_lateral = data(:,18);
forca_lateral = forca_lateral(cut:end);
forca_de_tracao = data(:,19);
forca_de_tracao = forca_de_tracao(cut:end);
momento_de_rolamento = data(:,20);
momento_de_rolamento = momento_de_rolamento(cut:end);
momento_de_arfagem = data(:,21);
momento_de_arfagem = momento_de_arfagem(cut:end);
momento_de_guinada = data(:,22);
momento_de_guinada = momento_de_guinada(cut:end);
wing_span = data(:,23);
wing_span = wing_span(cut:end);
u = data(:,24);
u = u(cut:end);
v = data(:,25);
v = v(cut:end);
w = data(:,26);
w = w(cut:end);
posicao_do_flap = data(:,27);
posicao_do_flap = posicao_do_flap(cut:end);
velocidade_mach = data(:,28);
velocidade_mach = velocidade_mach(cut:end);
Altitude_2 = data(:,29);
Altitude_2 = Altitude_2(cut:end);
elevator_2 = data(:,30);
elevator_2 = elevator_2(cut:end);
CD0 = data(:,31);
CD0 = CD0(cut:end);
CDalpha = data(:,32);
CDalpha = CDalpha(cut:end);
CDbeta = data(:,33);
CDbeta = CDbeta(cut:end);
CDde = data(:,34);
CDde = CDde(cut:end);
CDflap = data(:,35);
CDflap = CDflap(cut:end);
CDgear = data(:,36);
CDgear = CDgear(cut:end);
CDmach = data(:,37);
CDmach = CDmach(cut:end);
CDsb = data(:,38);
CDsb = CDsb(cut:end);
qbar_psf = data(:,39);
qbar_psf = qbar_psf(cut:end);
Sw_sqft = data(:,40);
Sw_sqft = Sw_sqft(cut:end);
Cm0 = data(:,41);
Cm0 = Cm0(cut:end);
Cmalpha = data(:,42);
Cmalpha = Cmalpha(cut:end);
Cmadot = data(:,43);
Cmadot = Cmadot(cut:end);
Cmde = data(:,44);
Cmde = Cmde(cut:end);
Cmaq = data(:,45);
Cmaq = Cmaq(cut:end);
momento_de_arfagem_gear = data(:,46);
momento_de_arfagem_gear = momento_de_arfagem_gear(cut:end);
momento_de_arfagem_prop = data(:,47);
momento_de_arfagem_prop = momento_de_arfagem_prop(cut:end);
momento_de_arfagem_total = data(:,48);
momento_de_arfagem_total = momento_de_arfagem_total(cut:end);
momento_de_arfagem_stab = data(:,49);
momento_de_arfagem_stab = momento_de_arfagem_stab(cut:end);
momento_de_arfagem_wind = data(:,50);
momento_de_arfagem_wind = momento_de_arfagem_wind(cut:end);

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
ylabel('ângulo (graus)')

subplot(2,1,2)
plot(tempo,beta)
title('tempo x Angulo de derrapagem')
xlabel('tempo (s)')
ylabel('ângulo (graus)')

figure
subplot(3,1,1)
plot(tempo,phi)
title('tempo x Angulo de rolamento')
xlabel('tempo (s)')
ylabel('ângulo (graus)')


subplot(3,1,2)
plot(tempo,teta)
title('tempo x Angulo de arfagem')
xlabel('tempo (s)')
ylabel('ângulo (graus)')

subplot(3,1,3)
plot(tempo,psi)
title('tempo x Angulo de guinada')
xlabel('tempo (s)')
ylabel('ângulo (graus)')

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

%% ---------------- plot de forças ----------------%%
figure
subplot(4,1,1)
plot(tempo,forca_de_arrasto)
title('tempo x força de arrasto')
xlabel('tempo (s)')
ylabel('Força (lbs)')

subplot(4,1,2)
plot(tempo,forca_de_sustentacao)
title('tempo x força de sustentação')
xlabel('tempo (s)')
ylabel('Força (lbs)')

subplot(4,1,3)
plot(tempo,forca_lateral)
title('tempo x força lateral')
xlabel('tempo (s)')
ylabel('Força (lbs)')

subplot(4,1,4)
plot(tempo,forca_de_tracao)
title('tempo x força de tração')
xlabel('tempo (s)')
ylabel('Força (lbs)')

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

%% ---------------- plot de flap position ----------------%%
figure
plot(tempo,posicao_do_flap)
title('tempo x posição do flap')
xlabel('tempo(s)')
ylabel('posição do flap')

%% ---------------- Velocidade em mach ----------------%%
figure
plot(tempo,velocidade_mach)
title('tempo x velocidade')
xlabel('tempo(s)')
ylabel('Velocidade (mach)')

%% ---------------- Velocidade 2 ----------------%%
figure
plot(tempo,Altitude_2)
title('tempo x Altitude')
xlabel('tempo(s)')
ylabel('Altitude (ft)')