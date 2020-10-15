function [error_percentual_max,erro_quadratico,erro_abs_medio] = return_erros(sim,FG_sim,cut)
    FG_sim = FG_sim(3:end);
    sim = sim(3:end);
    
    error = abs(sim - FG_sim);    
    erro_abs_medio = sum(error(:))/length(sim);
    erro_quadratico = sqrt(mean(error.^2));
    
    for i=1:size(FG_sim)
        if(abs(FG_sim(i)) < cut)
            FG_sim(i) = FG_sim(i);
            sim(i) = FG_sim(i);
        end
    end
    
    for i=1:size(sim)
        if(abs(sim(i)) < cut)
            FG_sim(i) = sim(i);
            sim(i) = sim(i);
        end
    end
    
    error = abs(sim - FG_sim);  
    error_percentual_max = 100*(max(error./(abs(FG_sim))));

end