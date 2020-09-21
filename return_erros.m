function [error_percentual_max,erro_quadratico,erro_abs_medio] = return_erros(sim,FG_sim)
    FG_sim = FG_sim(3:end);
    sim = sim(3:end);

    error = abs(sim - FG_sim);
    error_percentual_max = 100*(max(error./(abs(FG_sim))));
    erro_abs_medio = sum(error(:))/length(sim);
    erro_quadratico = sqrt(mean(error.^2));
end