% Dados do Cessna T37
% Sources:
% 
%       * http://www.wpafb.af.mil/museum/newold/t37.htm
%       SPECIFICATIONS
%         Span:   10.32 meters (33 ft. 10 in.)
%         Length:  8.92 meters (29 ft.  4 in.)
%         Height:  2.79 meters ( 9 ft.  5 in.)
%         Weight: 4,056 lbs. empty
%                 6,580 lbs. max.
%         Armament: None
%         Engines: Two Continental J69-T-25s of 1,025 lbs. thrust ea.
%         Crew: Two
% 
%       PERFORMANCE
%         Maximum speed:   425 mph (370 Kt)
%         Cruising speed:  350 mph.
%         Range:           650 miles
%         Service Ceiling: 35,000 ft.
% 
%     * Jeff Scott
%       Cessna A-37/T-37, cruise configuration
%       small twin jet engine military trainer, data from:
%         Roskam, Jan. Airplane Flight Dynamics and Automatic Flight
%         Controls, Part I. Lawrence KS: DARcorporation, 1995,
%         pg 501-503



%% ---------------------------------------------------- %%

% Dados do aviao Cessna T3T
% Fonte: FlightGear versao 0.9.2

% Indicacao se o modelo serï¿½usado para
% simulacao ou determinacao da cond. de equilibrio.
isTrimming = 0;

% Dados geomï¿½ricos
% ft -> m
% Area da asa
Sw = 182*0.09290304;
% Comprimento da asa
Bw = 33.83*0.3048;
% Corda media da asa
Cw = 5.47*0.3048;

% Momentos de inercia e produto de inercia
% slug*ft^2 -> kg*m^2
Jxx = 7985*1.3558179;
Jyy = 6000*1.3558179;
Jzz = 11183*1.3558179;
Jxz = 0;

% Massa da aeronave
% lb (pounds) -> kg.
M = 4056*0.45359237;

% Posicao do c.g. nominal e atual, no referencial estrutural.
% in (inches) -> m
Aero_RP = [0.0  0.0 0.0]*25.4e-3;

% Originalmente, segundo o arquivo de dados do
% simulador FlightGear, o c.g. era dianteiro => estabilidade.
% Rcg = [41.0  0.0 36.5]*25.4e-3;
Rcg = [0.0  0.0 -8.8]*25.4e-3;

% Eixo estrutural definido como:
%    x -> para trás;
%    y -> para a direita;
%    z -> para cima.
Aero_RP = Aero_RP*[-1 0 0;0 1 0;0 0 -1];
Rcg = Rcg*[-1 0 0;0 1 0;0 0 -1];

% Posicao do motor 1
% in (inches) -> m
Rengine1 = [40.0 -30.0 0.0]*25.4e-3;
Rengine1 = Rengine1*[-1 0 0;0 1 0;0 0 -1];

% Posicao do motor 2
% in (inches) -> m
Rengine2 = [40.0 30.0 0.0]*25.4e-3;
Rengine2 = Rengine2*[-1 0 0;0 1 0;0 0 -1];

% Estimativa de tracao maxima = Peso (g = 10m/s^2)
Tmax = M*10;

% Limites dos comandos da aeronave:
aileron_limits = [-0.35 0.35]*pi/180;
rudder_limits = [-0.35 0.35]*pi/180;
elevator_limits = [-0.35 0.3]*pi/180;
thrust_limits = [0 1];

% Condicao inicial para o aviao no ar.
%N ALTERAMOS
x0 = zeros(12,1);
x0(3) = 1000;     % H (m)
x0(4) = 100/3.6;   % U (m/s)
x0(11) = 2*pi/180; % theta (rad)

u0 = zeros(4,1);

% Dados aerodinamicos

% ----------------- LIFT -----------------------%

% Mudanca em CL devido a proximidade do solo.
% Variavel de entrada: aero/h_b-mac-ft (altura em relaï¿½o ao solo da asa na posicao
% da MAC dividida pelo comprimento da asa - wingspan)
% Obs.: Fator multiplicativo
CL_ground_effect = ...
	     [0.0000	1.0610
          0.1000	1.0330
          0.1500	1.0310
          0.2000	1.0330
          0.3000	1.0280
          0.4000	1.0110
          0.5000	1.0090
          0.6000	1.0050
          0.7000	1.0020
          0.8000	1.0000
          0.9000	1.0000
          1.0000	1.0000
          1.1000	1.0000];

% CL quando alpha = 0.
%CL_zero = 0.307; % comentamos pq não tinha no xml do T37

% CL devido a alpha.
% Entrada: alpha (rad).
CL_alpha = ...
	     [-0.2000	-0.6400
          0.0000	0.0800
          0.2600	1.3390
          0.6000	0.4480];

% CL devido a deflexao do Flap
% Entrada: comando de flap (adimensional).
% Originalmente, dezenas de graus de deflexao do flap.
CL_flap = 0.3500;

% CL devido a derivada de alpha.
% Obs.: valor constante multiplicado por cw/(2*Vt) e por alpha_dot (rad/s).
CL_alpha_dot = 2.0;

% CL devido a derivada de theta = q.
% Entrada: pitch rate q (rad/s).
% Obs.: valor constante multiplicado por cw/(2*Vt)
CL_q = 4.1;

% CL devido a defexao do profundor.
% Obs.: Coef. multiplicativo para deflexao do prof. (rad).
CL_elev = 0.5;

% ----------------- DRAG -----------------------%
CD_ground_effect=...
    [0.0000	0.8100
      0.1000	0.9900
      0.1500	0.9500
      0.2000	0.9800
      0.3000	0.9900
      0.4000	1.0000
      0.5000	1.0400
      0.6000	1.0100
      0.7000	0.9900
      0.8000	1.0100
      0.9000	1.0000
      1.0000	1.0000
      1.1000	1.0000];
    
% CD quando alpha = 0.
CD_zero = ...
	[  -1.5700	1.5000
      -0.2600	0.0480
      0.0000	0.0240
      0.2600	0.0480
      1.5700	1.5000]; 

% CD devido a alpha.
% Entrada: alpha (rad). 
CD_alpha = 0.3840;

% CD devido a beta.
% Obs.: Coef. multiplicativo para beta (rad).
CD_beta = ...
    [-1.5700	1.2300
      -0.2600	0.0500
      0.0000	0.0000
      0.2600	0.0500
      1.5700	1.2300];

% CD devido a posicao do Flap.
% Entradas: alpha (rad) e comando de flap (0, 1, 2 ou 3).
% Obs.: entrada 1 -> coluna 1 (2:end,1)
%       entrada 2 -> linha 1 (1,2:end)
CD_flap = 0.0750;

%CD devido a posição do elevator
CD_de = 0.0750;

CDmach=...
    [0.0000	0.0000
  0.7700	0.0000
  1.1000	0.0230
  1.8000	0.0150];
    

% ----------------- SIDE -----------------------%

% CY devido a beta.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por beta.
CY_beta = -0.3460;

% CY devido a roll rate - p.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por p (rad/s) e por bw/(2*VT).
CY_p = -0.0827;

% CY devido a yaw rate - r.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por r (rad/s) e por bw/(2*VT).
CY_r = 0.3000;

% CY devido a deflexao do leme.
% Obs.: coeficiente multiplicativo para delta_rudder (rad).
CY_rudder = 0.200;

% ----------------- Roll -----------------------%

% Cl devido a beta.
% Entradas: beta (rad) e alpha (rad).
% Obs.: entrada 1 -> coluna 1 (2:end,1)
%       entrada 2 -> linha 1 (1,2:end)
Cl_beta = -0.0944;

% Cl devido a roll rate - p.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por p (rad/s) e por bw/(2*VT).
Cl_p = -0.4420;

% Cl devido a yaw rate - r.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por p (rad/s) e por bw/(2*VT).
Cl_r = 0.0926;

% CY devido a deflexao do aileron.
% Obs.: coeficiente multiplicativo para aileron (rad).
Cl_ail = [0.0000	0.1810
      2.0000	0.0400];

% CY devido a deflexao do leme.
% Obs.: coeficiente multiplicativo para leme (rad).
Cl_rudder = 0.0150;


% ----------------- Pitch -----------------------%

% Cm para alpha = 0.
Cm_zero = 0.0250;

% Cl devido a alpha.
% Entrada: alpha (rad).
Cm_alpha = -0.7000;

% Cm devido a alpha rate.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por alpha_dot (rad/s) e por cw/(2*VT).
Cm_alpha_dot = -6.9500;

% Cm devido a pitch rate - q.
% Obs.: coeficiente multiplicativo para q (rad/s) e (cw/(2*VT)).
Cm_q = -50.0000;

% Cm devido a deflexao do flap.
% Entrada: comando do flap (0, 1, 2 ou 3).
% Obs.: Coeficiente adicionado ao Cm final.
% Cm_flap = ... NÃO TEM NO NOSSO XML
% 	  [0    0
%           1  -0.0654
%           2  -0.0981
%           3  -0.1140];

% Cm devido a deflexao do profundor.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado pela deflexao de profundor.
Cm_elev = ...
	[0.0000	-1.1200
     2.0000	-0.2000];

% ----------------- YAW ----------------------%

% Cn devido a beta.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por beta.
Cn_beta = 0.1106;

% Cn devido a roll rate - p.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por p e por (bw/(2*VT)).
Cn_p = -0.0243;

% Cn devido a yaw rate - r.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por r e por (bw/(2*VT)).
Cn_r = -0.1390;

% % Cn devido a deflexao de aileron. N TEM NO XML
% % Entrada: alpha (rad).
% % Obs.: Coeficiente multiplicado por delta_ail (rad).
% Cn_ail = ... 
% 	[0.0000  -0.0216
%          0.0943  -0.0504];

% Cn devido a deflexao de leme.
% Entrada: alpha (rad).
% Obs.: Coeficiente multiplicado por delta_rudder (rad).
Cn_rudder = -0.0365;

%Adverse yaw
Cnda=-0.0254;






