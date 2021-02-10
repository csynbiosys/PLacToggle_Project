function [fit_res] = setAMIGOStructureFit(fit_res, fit_dat)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % Section shared by both systems. 
    fit_res.inputs.exps.n_exp = length(fit_res.exps);
    fit_res.inputs.exps.data_type='real';
    fit_res.inputs.exps.noise_type='hetero_proportional';
    
    fit_res.inputs.ivpsol.ivpsolver='cvodes';
    fit_res.inputs.ivpsol.senssolver='fdsens5';
    fit_res.inputs.ivpsol.rtol=1.0D-13;
    fit_res.inputs.ivpsol.atol=1.0D-13;
    fit_res.inputs.plotd.plotlevel='noplot';
    
    %COST FUNCTION RELATED DATA
    fit_res.inputs.PEsol.PEcost_type='llk';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost'
    fit_res.inputs.PEsol.lsq_type='hetero';                      % [] To be defined for llk function, 'homo' | 'homo_var' | 'hetero'

    %OPTIMIZATION
    fit_res.inputs.nlpsol.nlpsolver='eSS';
    fit_res.inputs.nlpsol.eSS.maxeval = 200000;
    fit_res.inputs.nlpsol.eSS.maxtime = 50000000;
    fit_res.inputs.nlpsol.eSS.local.solver = 'lsqnonlin'; 
    fit_res.inputs.nlpsol.eSS.local.finish = 'lsqnonlin'; 
    
    
    % Things specific for the system
    switch fit_res.system 
        case "PL"
            % Specify folder name and short_name
            results_folder = strcat('MPL',datestr(now,'yyyy-mm-dd'));
            short_name     = strcat('MPL_fitation');
            fit_res.inputs.pathd.results_folder = results_folder;                        
            fit_res.inputs.pathd.short_name     = short_name;
            fit_res.inputs.pathd.runident       = 'initial_setup';
        case "TS"
            % Specify folder name and short_name
            results_folder = strcat('MTS',datestr(now,'yyyy-mm-dd'));
            short_name     = strcat('MTS_fitation');
            fit_res.inputs.pathd.results_folder = results_folder;                        
            fit_res.inputs.pathd.short_name     = short_name;
            fit_res.inputs.pathd.runident       = 'initial_setup';
            
            % To know which model and set of parameters the user wants to load.
            fit_res.inputs = ExtractModelTSFit(fit_res, fit_dat);
            AMIGO_Prep(fit_res.inputs)
    end
    
    
    for j = 1:length(fit_res.exps)
        switch fit_res.system 
            case "PL"
                % To know which model and set of parameters the user wants to load.
                fit_res.inputs = ExtractModelPSFit(fit_res, fit_dat, j);
                fit_res.inputs.exps.exp_data{j} = fit_res.exps{j}.CitrineMean;
                fit_res.inputs.exps.error_data{j} = fit_res.exps{j}.CitrineSD;
                fit_res.inputs.exps.u{j}= fit_res.exps{j}.inp;                            % IPTG values for the input

            case "TS"
                fit_res.inputs.exps.exp_data{j} = [fit_res.exps{j}.RFPMean, fit_res.exps{j}.GFPMean];
                fit_res.inputs.exps.error_data{j} = [fit_res.exps{j}.RFPSD, fit_res.exps{j}.GFPSD];
                fit_res.inputs.exps.u{j}= fit_res.exps{j}.inp+1e-7;                            % IPTG values for the input
                
                switch fit_dat.model
                    case 1
                        fit_res.inputs.exps.n_obs{j}=2;                         % Number of observables per experiment
                        fit_res.inputs.exps.obs_names{j} = char('LacI_M1','TetR_M1');
                        fit_res.inputs.exps.obs{j} = char('LacI_M1 = L_RFP','TetR_M1 = T_GFP');
        %                 fit_res.inputs.exps.obs{j} = char('LacI_M1 = L_RFP_AU','TetR_M1 = T_GFP_AU');% Name of the observables 
                        y01=M1_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[28.510, 1363.193],...
                            [1, 0]+1e-7);
                        fit_res.inputs.exps.exp_y0{j}=M1_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[y01(3), y01(4)],...
                            [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{j}=M1SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
        %                     [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
                    case 2
                        fit_res.inputs.exps.n_obs{j}=2;                         % Number of observables per experiment
                        fit_res.inputs.exps.obs_names{j} = char('LacI_M2','TetR_M2');
                        fit_res.inputs.exps.obs{j} = char('LacI_M2 = L_RFP','TetR_M2 = T_GFP');
        %                 fit_res.inputs.exps.obs{j} = char('LacI_M2 = L_RFP_AU','TetR_M2 = T_GFP_AU');% Name of the observables 
                        y01=M2_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[28.510, 1363.193],...
                            [1, 0]+1e-7);
                        fit_res.inputs.exps.exp_y0{j}=M2_Compute_SteadyState_OverNight(fit_res.inputs,...
                            fit_res.inputs.model.par,[y01(3), y01(4)],...
                            [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{j}=M2SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{j}.RFPMean(1), fit_res.exps{j}.GFPMean(1)],...
        %                     [fit_res.exps{j}.preIPTG, fit_res.exps{j}.preaTc]+1e-7);
                end
                
        end
        
        % Experiment details for AMIGO
        fit_res.inputs.exps.t_f{j}=round(fit_res.exps{j}.time(end));          % Experiment duration
        fit_res.inputs.exps.n_s{j}=length(fit_res.exps{j}.time);              % Number of sampling times
        fit_res.inputs.exps.t_s{j}=round(fit_res.exps{j}.time)';         % Times of samples
        fit_res.inputs.exps.u_interp{j}='step';                                % Interpolating function for the input
        fit_res.inputs.exps.n_steps{j}=length(fit_res.exps{j}.evnT)-1;                  % Number of steps in the input
%         fit_res.inputs.exps.u{j}= fit_res.exps{j}.inp;                            % IPTG values for the input
        fit_res.inputs.exps.t_con{j}=round(fit_res.exps{j}.evnT);                     % Switching times
    end

    
    % GLOBAL UNKNOWNS for PE
    boundperIter = setGuessAndBounds(fit_res, fit_dat);
    fit_res.inputs.PEsol.id_global_theta=fit_res.inputs.model.par_names;
    switch fit_res.system
        case "PL"
            switch fit_dat.model
                case 1
                    switch fit_dat.iter
                        case 1
                            fit_res.global_theta_guess=boundperIter.Iter0.PLac1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter0.PLac1.max;  % Maximum allowed values for the paramters
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter0.PLac1.min;  % Minimum allowed values for the parameters
                        case 2
                            fit_res.global_theta_guess=boundperIter.Iter1.PLac1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter1.PLac1.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter1.PLac1.min;
                        case 3
                            fit_res.global_theta_guess=boundperIter.Iter2.PLac1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter2.PLac1.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter2.PLac1.min;
                    end
                case 2
                    switch fit_dat.iter
                        case 1
                            fit_res.global_theta_guess=boundperIter.Iter0.PLac2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter0.PLac2.max;  % Maximum allowed values for the paramters
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter0.PLac2.min;  % Minimum allowed values for the parameters
                        case 2
                            fit_res.global_theta_guess=boundperIter.Iter1.PLac2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter1.PLac2.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter1.PLac2.min;
                        case 3
                            fit_res.global_theta_guess=boundperIter.Iter2.PLac2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter2.PLac2.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter2.PLac2.min;
                    end
            end
        case "TS"
            switch fit_dat.model
                case 1
                    switch fit_dat.iter
                        case 1
                            fit_res.global_theta_guess=boundperIter.Iter0.TS1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter0.TS1.max;  % Maximum allowed values for the paramters
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter0.TS1.min;  % Minimum allowed values for the parameters
                        case 2
                            fit_res.global_theta_guess=boundperIter.Iter1.TS1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter1.TS1.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter1.TS1.min;
                        case 3
                            fit_res.global_theta_guess=boundperIter.Iter2.TS1.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter2.TS1.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter2.TS1.min;
                    end
                case 2
                    switch fit_dat.iter
                        case 1
                            fit_res.global_theta_guess=boundperIter.Iter0.TS2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter0.TS2.max;  % Maximum allowed values for the paramters
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter0.TS2.min;  % Minimum allowed values for the parameters
                        case 2
                            fit_res.global_theta_guess=boundperIter.Iter1.TS2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter1.TS2.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter1.TS2.min;
                        case 3
                            fit_res.global_theta_guess=boundperIter.Iter2.TS2.guess;
                            fit_res.inputs.PEsol.global_theta_max=boundperIter.Iter2.TS2.max; 
                            fit_res.inputs.PEsol.global_theta_min=boundperIter.Iter2.TS2.min;
                    end
            end
    end
    
    
    
    
end


















