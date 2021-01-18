function [simul_res] = setAMIGOStructureSimul(simul_res, simul_dat, countPL, countTS)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLac
    % Number of experiments
    if countPL ~= 0
        simul_res.inputsPL.exps.n_exp = countPL;
        simul_res.inputsPL.exps.data_type='pseudo';
        simul_res.inputsPL.exps.noise_type='hetero_proportional';
        % Specify folder name and short_name
        results_folder = strcat('MPL',datestr(now,'yyyy-mm-dd'));
        short_name     = strcat('MPL_Simulation');
        simul_res.inputsPL.pathd.results_folder = results_folder;                        
        simul_res.inputsPL.pathd.short_name     = short_name;
        simul_res.inputsPL.pathd.runident       = 'initial_setup';
        
        simul_res.inputsPL.ivpsol.ivpsolver='cvodes';
        simul_res.inputsPL.ivpsol.senssolver='fdsens5';
        simul_res.inputsPL.ivpsol.rtol=1.0D-13;
        simul_res.inputsPL.ivpsol.atol=1.0D-13;
        simul_res.inputsPL.plotd.plotlevel='noplot';

    end
    if countTS ~= 0
        simul_res.inputsTS.exps.n_exp = countTS;
        simul_res.inputsTS.exps.data_type='pseudo';
        simul_res.inputsTS.exps.noise_type='hetero_proportional';
        % Specify folder name and short_name
        results_folder = strcat('MTS',datestr(now,'yyyy-mm-dd'));
        short_name     = strcat('MTS_Simulation');
        simul_res.inputsTS.pathd.results_folder = results_folder;                        
        simul_res.inputsTS.pathd.short_name     = short_name;
        simul_res.inputsTS.pathd.runident       = 'initial_setup';
        
        simul_res.inputsTS.ivpsol.ivpsolver='cvodes';
        simul_res.inputsTS.ivpsol.senssolver='fdsens5';
        simul_res.inputsTS.ivpsol.rtol=1.0D-13;
        simul_res.inputsTS.ivpsol.atol=1.0D-13;
        simul_res.inputsTS.plotd.plotlevel='noplot';
        
        simul_res.inputsTS = ExtractModelTS(simul_res, simul_dat);
        AMIGO_Prep(simul_res.inputsTS)
    end
    
    for j = 1:countPL
        
        
        % To know which model and set of parameters the user wants to load.
        % 
        simul_res.inputsPL = ExtractModelPS(simul_res, simul_dat, j);

        % Experiment details for AMIGO
        simul_res.inputsPL.exps.t_f{j}=round(simul_res.expsPL{j}.time(end));          % Experiment duration
        simul_res.inputsPL.exps.n_s{j}=length(simul_res.expsPL{j}.time);              % Number of sampling times
        simul_res.inputsPL.exps.t_s{j}=round(simul_res.expsPL{j}.time)';         % Times of samples
        simul_res.inputsPL.exps.u_interp{j}='step';                                % Interpolating function for the input
        simul_res.inputsPL.exps.n_steps{j}=length(simul_res.expsPL{j}.evnT)-1;                  % Number of steps in the input
        simul_res.inputsPL.exps.u{j}= simul_res.expsPL{j}.inp;                            % IPTG values for the input
        simul_res.inputsPL.exps.t_con{j}=round(simul_res.expsPL{j}.evnT);                     % Switching times
        simul_res.inputsPL.exps.std_dev{j}=[0.0];
       
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOGGLE SWITCH
    
    for j = 1:countTS
        
                
        switch simul_dat.model
            case 0
                simul_res.inputsTS.exps.n_obs{j}=4;                         % Number of observables per experiment
                simul_res.inputsTS.exps.obs_names{j} = char('LacI_M1','TetR_M1', 'LacI_M2','TetR_M2');
                simul_res.inputsTS.exps.obs{j} = char('LacI_M1 = L_RFP','TetR_M1 = T_GFP', 'LacI_M2 = L_RFP2','TetR_M2 = T_GFP2');
    %                 simul_res.inputsTS.exps.obs{j} = char('LacI_M1 = L_RFP_AU','TetR_M1 = T_GFP_AU', 'LacI_M2 = L_RFP_AU2','TetR_M2 = T_GFP_AU2');% Name of the observables 
                simul_res.inputsTS.exps.exp_y0{j}=M1vsM2_Compute_SteadyState_OverNight_ModelSelection(simul_res.inputsTS,...
                    simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1), ...
                    simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
                    [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
%                 simul_res.inputsTS.exps.exp_y0{j}=M1vsM2SF_Compute_SteadyState_OverNight_ModelSelection(simul_res.inputsTS,...
%                     simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1), ...
%                     simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
%                     [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
            case 1
                simul_res.inputsTS.exps.n_obs{j}=2;                         % Number of observables per experiment
                simul_res.inputsTS.exps.obs_names{j} = char('LacI_M1','TetR_M1');
                simul_res.inputsTS.exps.obs{j} = char('LacI_M1 = L_RFP','TetR_M1 = T_GFP');
%                 simul_res.inputsTS.exps.obs{j} = char('LacI_M1 = L_RFP_AU','TetR_M1 = T_GFP_AU');% Name of the observables 
                simul_res.inputsTS.exps.exp_y0{j}=M1_Compute_SteadyState_OverNight(simul_res.inputsTS,...
                    simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
                    [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
%                 simul_res.inputsTS.exps.exp_y0{j}=M1SF_Compute_SteadyState_OverNight(simul_res.inputsTS,...
%                     simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
%                     [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
            case 2
                simul_res.inputsTS.exps.n_obs{j}=2;                         % Number of observables per experiment
                simul_res.inputsTS.exps.obs_names{j} = char('LacI_M2','TetR_M2');
                simul_res.inputsTS.exps.obs{j} = char('LacI_M2 = L_RFP','TetR_M2 = T_GFP');
%                 simul_res.inputsTS.exps.obs{j} = char('LacI_M2 = L_RFP_AU','TetR_M2 = T_GFP_AU');% Name of the observables 
                simul_res.inputsTS.exps.exp_y0{j}=M2_Compute_SteadyState_OverNight(simul_res.inputsTS,...
                    simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
                    [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
%                 simul_res.inputsTS.exps.exp_y0{j}=M2SF_Compute_SteadyState_OverNight(simul_res.inputsTS,...
%                     simul_res.inputsTS.model.par,[simul_res.expsTS{j}.RFPMean(1), simul_res.expsTS{j}.GFPMean(1)],...
%                     [simul_res.expsTS{j}.preIPTG, simul_res.expsTS{j}.preaTc]+1e-7);
        end

        % To know which model and set of parameters the user wants to load.
        % 
        
        
        % Experiment details for AMIGO
        simul_res.inputsTS.exps.t_f{j}=round(simul_res.expsTS{j}.time(end));          % Experiment duration
        simul_res.inputsTS.exps.n_s{j}=length(simul_res.expsTS{j}.time);              % Number of sampling times
        simul_res.inputsTS.exps.t_s{j}=round(simul_res.expsTS{j}.time)';         % Times of samples
        simul_res.inputsTS.exps.u_interp{j}='step';                                % Interpolating function for the input
        simul_res.inputsTS.exps.n_steps{j}=length(simul_res.expsTS{j}.evnT)-1;                  % Number of steps in the input
        simul_res.inputsTS.exps.u{j}= simul_res.expsTS{j}.inp;                            % IPTG and aTc values for the input
        simul_res.inputsTS.exps.t_con{j}=round(simul_res.expsTS{j}.evnT);                     % Switching times
        simul_res.inputsTS.exps.std_dev{j}=[0.0];
    end


end


























