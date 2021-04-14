%% Cost function for GFP Case
% This script computs the cost function as the euclidean distance
% of GFP simulations of the 2 models. 

% Inputs: 
%       - od: Input profile to be tested
%       - inputs,results,privstruct: AMIGO structures

function [f,g,h] = OEDModelSelectionCostPLac(od)

global input_par3
inputs = input_par3;

% Set the experimental structure
   
    inputsSIM.model = inputs.model;
    inputsSIM.pathd.results_folder = inputs.pathd.results_folder;                        
    inputsSIM.pathd.short_name     = inputs.pathd.short_name;
    inputsSIM.pathd.runident       = inputs.pathd.runident;
    clear newExps;
    newExps.n_exp = 1;                                         % Number of experiments 
    newExps.n_obs{1}=2;                                        % Number of observables per experiment        
    newExps.obs_names{1} = char('CitM1','CitM2');
    newExps.obs{1} = char('CitM1 = Cit_AU','CitM2 = Cit_AU_2');% Name of the observables 
    newExps.exp_y0{1}=inputs.exps.exp_y0{1};                                      % Initial condition for the experiment    

    newExps.t_f{1}=inputs.exps.t_f{1}+180-5;                                   % Experiment duration
    newExps.n_s{1}=(inputs.exps.t_f{1}+180)/5;                             % Number of sampling times
    newExps.t_s{1}=0:5:inputs.exps.t_f{1}+175 ;                              % Times of samples

    newExps.u_interp{1}='step';                                % Interpolating function for the input
    % newExps.u_interp{2}='step';                                % Interpolating function for the input
    newExps.n_steps{1}=inputs.exps.n_steps{1}+1;                  % Number of steps in the input
    newExps.u{1}= [0, od(1:inputs.exps.n_steps{1})];                                     % IPTG and aTc values for the input
    newExps.t_con{1}=[inputs.exps.t_con{1}, inputs.exps.t_f{1}+180-5];                     % Switching times
    %     newExps.t_con{1}=[0 3000];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Mock the experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    inputsSIM.exps = newExps;

    % SIMULATION
    inputsSIM.ivpsol.ivpsolver=inputs.ivpsol.ivpsolver;
    inputsSIM.ivpsol.senssolver=inputs.ivpsol.senssolver;
    inputsSIM.ivpsol.rtol=inputs.ivpsol.rtol;
    inputsSIM.ivpsol.atol=inputs.ivpsol.atol;

    inputsSIM.plotd.plotlevel='noplot';


    % Simulate the models 
    y = AMIGO_SModel_NoVer(inputsSIM);
    
    % Extract each simualtion vector
    Cit_mrna = y.sim.states{1}(:,1);
    Cit_foldedP = y.sim.states{1}(:,2);
    Cit_fluo = y.sim.states{1}(:,3);
    Cit_AU = y.sim.states{1}(:,4); 
    Cit_mrna_2 = y.sim.states{1}(:,5);
    Cit_foldedP_2 = y.sim.states{1}(:,6);
    Cit_fluo_2 = y.sim.states{1}(:,7);
    Cit_AU_2 = y.sim.states{1}(:,8); 

% Definition of the cost function to be minimised (average euclidean
% distance)

    % Euclidean distance for AU simulations
    subs = Cit_AU-Cit_AU_2;
    sqr = zeros(length(subs),1);
    for i=1:length(sqr)
        sqr(i,1) = subs(i,1)^2;
    end
    
    % Cost function
	f = -sqrt(sum(sqr));
    
	 h(1)=0;
	 g(1)=0;

return


















end


