clear;
%============================
% RESULTS PATHS RELATED DATA
%============================
inputs.pathd.results_folder='TSM2_PractIdent';% Folder to keep results (in Results) for a given problem
inputs.pathd.short_name='TSM2';          % To identify figures and reports for a given problem
inputs.pathd.runident='r1';                % [] Identifier used in order not to overwrite previous
                                           % results. May be modified from command line.'run1'(default)

%============================
% MODEL RELATED DATA
%============================
inputs.model = ToggleSwitch_load_model_M2SF_Iter0();
inputs.model.par(15:16) = [1.5, 1.5];                                            % These values may be updated during optimization


%==================================
% EXPERIMENTAL SCHEME RELATED DATA
%==================================
AMIGO_Prep(inputs); 
y0 = M2SF_Compute_SteadyState_OverNight(inputs,inputs.model.par,[26, 1300],[1, 0]+1e-7);

inputs.exps.n_exp=5;                                 % Number of experiments
for i = 1:5
    inputs.exps.n_obs{i}=2;                              % Number of observed quantities per experiment
    inputs.exps.obs_names{i}=char('LacI_M2','TetR_M2');          % Observables
    inputs.exps.obs{i}=char('LacI_M2 = L_RFP_AU','TetR_M2 = T_GFP_AU'); % Observation function
    inputs.exps.exp_y0{i}=y0;                 % Initial conditions for each experiment
    inputs.exps.t_f{i}=1435;                            % Experiments duration
    inputs.exps.n_s{i}=1440/5;                                % Number of sampling times
    inputs.exps.t_s{i}=0:5:1435; % Sampling times
end

rng(1234)

inputs.exps.u_interp{1}='step';
inputs.exps.u{1}=[1 0; 0 100]+1e-7;
inputs.exps.t_con{1}=[0,180,1435];
inputs.exps.n_steps{1} = 2;

inputs.exps.u_interp{2}='step';
inputs.exps.u{2}=[repelem(rand, 8); rand(1,8)*100]+1e-7;
inputs.exps.t_con{2}=[0:180:1435,1435];
inputs.exps.n_steps{2} = 8;

inputs.exps.u_interp{3}='step';
inputs.exps.u{3}=[rand(1,8); repelem(rand*100, 8)]+1e-7;
inputs.exps.t_con{3}=[0:180:1435,1435];
inputs.exps.n_steps{3} = 8;

inputs.exps.u_interp{4}='step';
inputs.exps.u{4}=[rand(1,8); rand(1,8)*100]+1e-7;
inputs.exps.t_con{4}=[0:180:1435,1435];
inputs.exps.n_steps{4} = 8;

inputs.exps.u_interp{5}='step';
inputs.exps.u{5}=[rand(1,12); repelem(rand*100, 12)]+1e-7;
inputs.exps.t_con{5}=[0:120:1435, 1435];
inputs.exps.n_steps{5} = 12;

inputs.ivpsol.ivpsolver='cvodes';
inputs.ivpsol.senssolver='fdsens5';
inputs.ivpsol.rtol=1.0D-13;
inputs.ivpsol.atol=1.0D-13;

%==================================
% EXPERIMENTAL DATA RELATED INFO
%==================================
inputs.exps.data_type='pseudo';                                       % Type of data: 'pseudo'|'real'
inputs.exps.noise_type='hetero_proportional';

simre = AMIGO_SData(inputs);

for i = 1:5
    inputs.exps.exp_data{i} = simre.sim.sim_data{i};
    inputs.exps.error_data{i} = simre.sim.error_data{i};
end


 %==================================
 % UNKNOWNS RELATED DATA
 %==================================
 
 inputs.PEsol.id_global_theta='all';                  % 'all'|User selected
 
 
   inputs.PEsol.global_theta_max= [0.4488,...
                              1.1220,...
                              0.3366,112.2018,336.6055,112.2018,5.1250,5.1250,...
                              1.7783,11.2202,336.6055,1.1220,5.1250,5.1250,...
                              100,100];           % Maximum allowed values for the paramters
    inputs.PEsol.global_theta_min= [0.0036,...
              0.0089,...
              0.0027,0.8913,2.6738,0.8913,0,0,...
              0.0056,0.0891,2.6738,0.0089,0,0,...
                              0.01,0.01];          % Minimum allowed values for the paramters
  ing = LHCS(inputs.PEsol.global_theta_max, inputs.PEsol.global_theta_min);
    inputs.PEsol.global_theta_guess = ing(1,:);  % Any parameter values can be introduced here


%==================================
% NUMERICAL METHDOS RELATED DATA
%==================================

% SIMULATION                                             % Default for charmodel C: CVODES

% OPTIMIZATION
fit_res.inputs.nlpsol.nlpsolver='eSS';
fit_res.inputs.nlpsol.eSS.maxeval = 200000;
fit_res.inputs.nlpsol.eSS.maxtime = 50000000;
fit_res.inputs.nlpsol.eSS.local.solver = 'lsqnonlin'; 
fit_res.inputs.nlpsol.eSS.local.finish = 'lsqnonlin'; 

% NUMBER OF SAMPLES IN RIdent

inputs.rid.conf_ntrials=1000;                             % Suggested >=500

%================================
% CALL AMIGO2 from COMMAND LINE
%================================
% It is recommended to keep all inputs in a 'problem_file'.m.
% AMIGO2 RIdent task can be called as follows:
% AMIGO_RIdent('problem_file','run_ident') or AMIGO_ContourP(inputs)

AMIGO_Prep(inputs);
PIdent = AMIGO_RIdent(inputs);

save("PracticalIdentifiability_Model2.mat", "PIdent")





