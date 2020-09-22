
% Encontra a condicao de equilibrio.
mytrim;

% Procedimento de Linearizacao a ser invocado
% depois que a condicao de equilibrio
% for encontrada, usando "mytrim".

[A,B,C,D] = linmod('trim_cessna182',x0,u0);

syslin = ss(A,B,C,D);

syslin.StateName{1} = 'P_N';
syslin.StateName{2} = 'P_E';
syslin.StateName{3} = 'H';
syslin.StateName{4} = 'U';
syslin.StateName{5} = 'V';
syslin.StateName{6} = 'W';
syslin.StateName{7} = 'P';
syslin.StateName{8} = 'Q';
syslin.StateName{9} = 'R';
syslin.StateName{10} = '\phi';
syslin.StateName{11} = '\theta';
syslin.StateName{12} = '\psi';

syslin.InputName{1} = '\delta ail';
syslin.InputName{2} = '\delta elev';
syslin.InputName{3} = '\delta rud';
syslin.InputName{4} = '\delta thr';

syslin.OutputName{1} = 'P_N';
syslin.OutputName{2} = 'P_E';
syslin.OutputName{3} = 'H';
syslin.OutputName{4} = 'U';
syslin.OutputName{5} = 'V';
syslin.OutputName{6} = 'W';
syslin.OutputName{7} = 'P';
syslin.OutputName{8} = 'Q';
syslin.OutputName{9} = 'R';
syslin.OutputName{10} = 'phi';
syslin.OutputName{11} = 'theta';
syslin.OutputName{12} = 'psi';

syslin.Notes = 'Modelo Cessna 182. EEUFMG. 11/2005.';

% Obtencao do modelo longitudinal, desprezando a altitude.
syslong = modred(syslin,[1 2 3 5 7 9 10 12],'del');
Along = syslong.A;
Blong = syslong.B;
Clong = eye(4);
Dlong = zeros(4,4);
syslong = ss(Along,Blong,Clong,Dlong);
syslong.StateName{1} = 'U';
syslong.StateName{2} = 'W';
syslong.StateName{3} = 'Q';
syslong.StateName{4} = '\theta';
syslong.InputName{1} = '\delta ail';
syslong.InputName{2} = '\delta elev';
syslong.InputName{3} = '\delta rud';
syslong.InputName{4} = '\delta thr';
syslong.OutputName{1} = 'U';
syslong.OutputName{2} = 'W';
syslong.OutputName{3} = 'Q';
syslong.OutputName{4} = '\theta';

% Obtencao do modelo lateral.
syslat = modred(syslin,[1 2 3 4 6 8 11 12],'del');
Alat = syslat.A;
Blat = syslat.B;
Clat = eye(4);
Dlat = zeros(4,4);
syslat = ss(Alat,Blat,Clat,Dlat);
syslat.StateName{1} = 'V';
syslat.StateName{2} = 'P';
syslat.StateName{3} = 'R';
syslat.StateName{4} = '\phi';
syslat.InputName{1} = '\delta ail';
syslat.InputName{2} = '\delta elev';
syslat.InputName{3} = '\delta rud';
syslat.InputName{4} = '\delta thr';
syslat.OutputName{1} = 'V';
syslat.OutputName{2} = 'P';
syslat.OutputName{3} = 'R';
syslat.OutputName{4} = '\phi';

clear Along Blong Clong Dlong Alat Blat Clat Dlat;

% Calcula as funcoes de transferencia
Glong = zpk(syslong);
Glat = zpk(syslat);

% Calculo das matrizes de sensibilidade modal.
[V,L] = eig(syslong.A);
Slong = real(V.*(inv(V.')));
disp(' ');
disp('Dinamica Longitudinal -> ** ANALISE MODAL **');
disp(' ');
for k=1:size(syslong.A,1),
disp(['Z',num2str(k),' => \lambda = ',num2str(L(k,k),4)]);
end
disp(' ');
disp('             Z1         Z2         Z3         Z4');
disp([strvcat('U','W','Q','\theta   '),num2str(Slong,4)]);

[V,L] = eig(syslat.A);
Slat = real(V.*(inv(V.')));
disp(' ');
disp('Dinamica Latero-Direcional -> ** ANALISE MODAL **');
disp(' ');
for k=1:size(syslat.A,1),
disp(['Z',num2str(k),' => \lambda = ',num2str(L(k,k),4)]);
end
disp(' ');
disp('             Z1         Z2         Z3         Z4');
disp([strvcat('V','P','R','\phi    '),num2str(Slat,4)]);

disp(' ');

% figure;
% bode(Glong);grid;

% figure;
% bode(Glat);grid;



