%% ----------------------------- For�a de arrasto ----------------------------------------- %%
[err_perc_max_farrasto,err_quadr_medio_farrasto,err_abs_med_farrasto] = return_erros(Forca_de_arrasto_sim,Forca_de_arrasto_FG_sim)

figure
plot(Forca_de_arrasto_sim,'b')
hold on
plot(Forca_de_arrasto_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('For�a de arrasto')
legend('Simula��o','Flightgear')

%% ----------------------------- For�a Lateral ----------------------------------------- %%
[err_perc_max_flateral,err_quadr_medio_flateral,err_abs_med_flateral] = return_erros(Forca_Lateral_sim,Forca_Lateral_FG_sim)

figure
plot(Forca_Lateral_sim,'b')
hold on
plot(Forca_Lateral_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('For�a Lateral')
legend('Simula��o','Flightgear')

%% ----------------------------- For�a de sustenta��o ----------------------------------------- %%
[err_perc_max_fsustentacao,err_quadr_medio_fsustentacao,err_abs_med_fsustentacao] = return_erros(Forca_de_sustentacao_sim,Forca_de_sustentacao_FG_sim)

figure
plot(Forca_de_sustentacao_sim,'b')
hold on
plot(Forca_de_sustentacao_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('For�a de sustenta��o')
legend('Simula��o','Flightgear')

%% ----------------------------- Momento de rolamento ----------------------------------------- %%
[err_perc_max_mrolamento,err_quadr_medio_mrolamento,err_abs_med_mrolamento] = return_erros(Momento_de_rolamento_sim, Momento_de_rolamento_FG_sim)

figure
plot(Momento_de_rolamento_sim,'b')
hold on
plot(Momento_de_rolamento_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('Momento de rolamento')
legend('Simula��o','Flightgear')

%% ----------------------------- Momento de arfagem ----------------------------------------- %%
[err_perc_max_marfagem,err_quadr_medio_marfagem,err_abs_med_marfagem] = return_erros(Momento_de_arfagem_sim,Momento_de_arfagem_FG_sim)

figure
plot(Momento_de_arfagem_sim,'b')
hold on
plot(Momento_de_arfagem_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('Momento de arfagem')
legend('Simula��o','Flightgear')

%% ----------------------------- Momento de guinada ----------------------------------------- %%
[err_perc_max_mguinada,err_quadr_medio_mguinada,err_abs_med_mguinada] = return_erros(Momento_de_guinada_sim,Momento_de_guinada_FG_sim)

figure
plot(Momento_de_guinada_sim,'b')
hold on
plot(Momento_de_guinada_FG_sim,'g')
xlabel('Sample')
ylabel('For�a(N)')
title('Momento de guinada')
legend('Simula��o','Flightgear')