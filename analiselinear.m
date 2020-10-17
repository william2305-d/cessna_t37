% Carrega os parametros do Cessna t-37
t37_data;

% Valores iniciais para a altitude, veocidade da aeronave
% em relacao ao vento, e para a altitude.
H = 5334; % 50% da altura maxima
VT = 547.176/3.6; % 80% da vel maxima

A = linsys2.A;
B = linsys2.B;
C = linsys2.C;
D = linsys2.D;

A(:, 1) = []; % Coluna P=0;
A(:, 2) = []; % Coluna R=0;
A(:, 4) = []; % Coluna V=0;
A(1, :) = []; % Linha P =0;
A(2, :) = []; % Linha R =0;
A(4, :) = []; % Linha V =0;
eig(A)

B(:,1) = []; % Corta coluna de aileron de B
B(:,2) = []; %Corta coluna de rudder de B
B(1, :) = []; % Linha P =0;
B(2, :) = []; % Linha R =0;
B(4, :) = []; % Linha V =0;

ueq = 151.9918;
weq = 0.66256;

dVt1=ueq/sqrt((ueq^2+weq^2))
dVt2=weq/sqrt((ueq^2+weq^2))

dalpha1 = -weq/(ueq^2+weq^2)
dalpha2 = ueq/(ueq^2+weq^2)

T = eye(5);

T(3, 3) = dVt1;
T(3, 4) = dVt2;
T(4, 3) = dalpha1;
T(4, 4) = dalpha2;


A_a = inv(T)*A*T;
B_a = inv(T)*B;
C_a = eye(5); %pROFESSOR Pediu pra ser a matriz identidade 5x5.
D_a = zeros(5,2)

eig(A_a)
%B_a = inv(T)*B