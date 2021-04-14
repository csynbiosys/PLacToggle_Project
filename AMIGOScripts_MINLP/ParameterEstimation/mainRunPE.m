
function [peRes] = mainRunPE(fit_res, fit_dat, flag, tmpth, s)

    fit_res.inputs.PEsol.global_theta_guess = tmpth;
    fit_res.inputs.model.par = tmpth;
    
    if fit_dat.iter == 1
        for j =1:fit_res.inputs.exps.n_exp
            switch fit_res.system
                case "PL"
                    fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                case "TS"
                    switch fit_dat.model
                        case 1
                            fit_res.inputs.exps.exp_y0{j}=M1_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
                            [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{j}=M1SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
        %                     [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
                        case 2
                            fit_res.inputs.exps.exp_y0{j}=M2_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
                            [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{j}=M2SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
        %                     [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
                    end
            end
        end
    end
    
%     AMIGO_Prep(fit_res.inputs)

    peRes = AMIGO_PE(fit_res.inputs);

    save(strjoin([".\Results\PE_", fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter, "_", flag, "\Run_", s, ".mat"], ""), "peRes")




end
