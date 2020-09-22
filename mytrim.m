% Script para trimagem do diagrama de simulacao de um Cessna 182

% Carrega os parametros do Cessna 182
c182_data;

% Valores iniciais para a altitude, veocidade da aeronave
% em relacao ao vento, e para a altitude.
H = 1000;
VT = 180/3.6;
alpha = 2*pi/180;
beta = 0;
phi = 0;
theta = alpha;
psi = 0;

% Valores iniciais para as entradas de controle.
ail = 0;
elev = 10*pi/180;
rud = 0;
thrust = 0.5;

% Notar que os estados P_N (posicao Norte) e
% P_E (posicao Leste) nao podem fazer parte da determinacao
% da condicao de equilibrio, pois estes estados
% devem estar sempre variando para que o aviao
% possa voar (velocidade diferente de zero em relacao a
% atmosfera parada)!
% Neste caso, o numero de estados do modelo para trimagem
% passa a ser 10, ao inves de 12;
% Isto foi resolvido no diagrama de simulacao usando
% a variavel "isTrimming" no bloco que calcula as
% velocidades em relacao ao referencial NED.

isTrimming = 1;

x0 = [
	0;			% P_N (m)
	0;			% P_E (m)
	H;			% H (m)
	VT*cos(beta)*cos(alpha);	% U (m/s)
	VT*sin(beta);			% V (m/s)
	VT*cos(beta)*sin(alpha);	% W (m/s)
	0;		% P (rad/s)
	0;		% Q (rad/s)
	0;		% R (rad/s)
	phi;				% phi (rad)
	theta;				% theta (rad)
	psi;				% psi (rad)
	];

u0 = [
	ail;	% Aileron (degrees)
	elev;	% Elevator (degrees)
	rud;	% Rudder (degrees)
	thrust;	% Normalized thrust
];

y0 = zeros(12,1);     % Outputs.

% Longitudinal dynamics
ix = [3 7 8 9 10 12]; % Frozen states.
iu = [1 3];   % Frozen inputs.
iy = [7 8 9]; % Frozen outputs.

dx = zeros(12,1);  % Initial guess for the derivatives.
idx = []; % Frozen derivatives.

% Optimization algorithm options.

%%     OPTIONS(1)-Display parameter (Default:0). 1 displays some results.
%%     OPTIONS(2)-Termination tolerance for X.(Default: 1e-4).
%%     OPTIONS(3)-Termination tolerance on F.(Default: 1e-4).
%%     OPTIONS(4)-Termination criterion on constraint violation.(Default: 1e-6)
%%     OPTIONS(5)-Algorithm: Strategy:  Not always used.
%%     OPTIONS(6)-Algorithm: Optimizer: Not always used.
%%     OPTIONS(7)-Algorithm: Line Search Algorithm. (Default 0)
%%     OPTIONS(8)-Function value. (Lambda in goal attainment. )
%%     OPTIONS(9)-Set to 1 if you want to check user-supplied gradients
%%     OPTIONS(10)-Number of Function and Constraint Evaluations.
%%     OPTIONS(11)-Number of Function Gradient Evaluations.
%%     OPTIONS(12)-Number of Constraint Evaluations.
%%     OPTIONS(13)-Number of equality constraints.
%%     OPTIONS(14)-Maximum number of function evaluations.
%%                 (Default is 100*number of variables)
%%     OPTIONS(15)-Used in goal attainment for special objectives.
%%     OPTIONS(16)-Minimum change in variables for finite difference gradients.
%%     OPTIONS(17)-Maximum change in variables for finite difference gradients.
%%     OPTIONS(18)-Step length. (Default 1 or less).

options = foptions;
n_steps = 20;
options(14) = n_steps*12;
options(2) = 1e-4;
options(3) = 1e-4;
options(1) = 1;

[x0,u0,y0,dx] = trim('trim_cessna182_v65',x0,u0,y0,ix,iu,iy,dx,idx,options);

% Zera estados de baixa amplitude.
x0(find(abs(x0) < 1e-5)) = 0;

% Zera entradas de pequena amplitude.
u0(find(abs(u0) < 1e-5)) = 0;

isTrimming = 0;

disp(' ');
disp('Condicoes de equilibrio: ');
disp(' ');
disp(['VT = ',num2str(norm(x0(4:6),2)*3.6),'km/h']);
disp(['alpha = ',num2str(atan2(x0(6),x0(4))*180/pi),' graus']);
disp(['theta = ',num2str(x0(11)*180/pi),' graus']);
disp(['H = ',num2str(x0(3)/1e3),' km']);
disp(['Profundor = ',num2str(u0(2)),' graus']);
disp(['Comando tracao = ',num2str(u0(4)*100),'%']);
disp(' ');

