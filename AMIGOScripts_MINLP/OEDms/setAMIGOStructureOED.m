function [oed_res] = setAMIGOStructureOED(oed_res, oed_dat)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % Section shared by both systems. 
   
    oed_res.inputs.ivpsol.ivpsolver='cvodes';
    oed_res.inputs.ivpsol.senssolver='fdsens5';
    oed_res.inputs.ivpsol.rtol=1.0D-13;
    oed_res.inputs.ivpsol.atol=1.0D-13;
    oed_res.inputs.plotd.plotlevel='noplot';


    %OPTIMIZATION
    oed_res.inputs.minlpsol.minlpsolver='eSS';
switch oed_res.inputs.minlpsol.minlpsolver
%     opts = 
%          solver: 'nomad'
%         maxiter: 1500
%        maxfeval: 10000
%        maxnodes: 10000
%         maxtime: 1000
%         tolrfun: 1.0000e-07
%         tolafun: 1.0000e-07
%          tolint: 1.0000e-05
%      solverOpts: []
%     dynamicOpts: []
%         iterfun: []
%        warnings: 'critical'
%         display: 'iter'
%      derivCheck: 'off'

    case {'Nomad','nomad'}
%%%%%%%%%%%%%%%%%%%%%%%%%%%% NOMAD %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        oed_res.inputs.minlpsol.nomad.maxfeval = 6e6;
        oed_res.inputs.minlpsol.nomad.maxiter = 6e6;
        oed_res.inputs.minlpsol.nomad.maxtime = 6e10;
        oed_res.inputs.minlpsol.nomad.xtype = 'IIIIIII'; % I=Integer, C=Continuous, B=Binary
        oed_res.inputs.minlpsol.nomad.history_file = ['History_', short_name, '.csv'];
        oed_res.inputs.minlpsol.nomad.stats_file = ['Stats_', short_name, '.csv'];
    
    case {'eSS','ess'}
%%%%%%%%%%%%%%%%%%%%%%%%%%%% eSS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

        oed_res.inputs.minlpsol.ess.maxeval = 6e5;
        oed_res.inputs.minlpsol.ess.maxtime = 1e5;
        oed_res.inputs.minlpsol.ess.int_var = 7; % I=Integer, C=Continuous, B=Binary
        oed_res.inputs.minlpsol.ess.log_var=[];
        oed_res.inputs.minlpsol.ess.tolc = 1e-7;
        oed_res.inputs.minlpsol.ess.local.solver = 'misqp';

    case {'VNS','vns'}
%%%%%%%%%%%%%%%%%%%%%%%%%%%% VNS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

        oed_res.inputs.minlpsol.vns.maxeval = 6e5;
        oed_res.inputs.minlpsol.vns.maxtime = 1e5;
        oed_res.inputs.minlpsol.vns.maxdist = 0.5;
        oed_res.inputs.minlpsol.vns.use_local = 1; % 1 = yes, 0 = no
    
    case {'GA','ga'}    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GenAlg %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % https://uk.mathworks.com/help/gads/mixed-integer-optimization.html
    % It needs Global Optimization Toolbox to be installed
    
        oed_res.inputs.minlpsol.ga.nvars = inputs.exps.n_steps{1};
        oed_res.inputs.minlpsol.ga.IntCon = [1:inputs.minlpsol.ga.nvars];


        oed_res.inputs.minlpsol.ga.PopulationSize = (min(max(10*inputs.minlpsol.ga.nvars,40),100));
        oed_res.inputs.minlpsol.ga.ConstraintTolerance = 1e-3;
        oed_res.inputs.minlpsol.ga.CrossoverFcn = 'crossoverscattered';
        oed_res.inputs.minlpsol.ga.CrossoverFraction = 0.8;
        oed_res.inputs.minlpsol.ga.Display = 'off';
        oed_res.inputs.minlpsol.ga.EliteCount = ceil(0.05*inputs.minlpsol.ga.PopulationSize);
        oed_res.inputs.minlpsol.ga.FitnessLimit = -Inf;
        oed_res.inputs.minlpsol.ga.FitnessScalingFcn = 'fitscalingrank';
        oed_res.inputs.minlpsol.ga.FunctionTolerance = 1e-6;
        oed_res.inputs.minlpsol.ga.MaxGenerations = 100*inputs.minlpsol.ga.nvars;
        oed_res.inputs.minlpsol.ga.MaxStallGenerations = 50;
        oed_res.inputs.minlpsol.ga.MaxTime = Inf;
        oed_res.inputs.minlpsol.ga.MigrationFraction = 0.2;
        oed_res.inputs.minlpsol.ga.MigrationInterval = 20;
    
    case {'ACO', 'aco'}    
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACO %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        oed_res.inputs.minlpsol.aco.nint=inputs.exps.n_steps{1};
        oed_res.inputs.minlpsol.aco.acc = 1e-10;        % Restriction tolerance and termination criterion for local solver
        oed_res.inputs.minlpsol.aco.maxit = 3;  % Maxim number iterations 100000000
        oed_res.inputs.minlpsol.aco.maxun = 3;  % Maximum number of consecutive iterations without improvement 100000000
        oed_res.inputs.minlpsol.aco.maxfun = 3;   % Maximum function evaluations 1000000
        oed_res.inputs.minlpsol.aco.maxtime = 3;        % Maximum time for solver run (in seconds)
        oed_res.inputs.minlpsol.aco.startloc = false;   % Start with local solver run (true/false)
        oed_res.inputs.minlpsol.aco.maxeval = 3;  % maximal evaluations (e.g. 1000000)
        oed_res.inputs.minlpsol.aco.oracle  = -Inf; % oracle parameter for penalty function
        oed_res.inputs.minlpsol.aco.ants  = 3; % default 1000
    
    case {'MITS', 'mits'}
%%%%%%%%%%%%%%%%%%%%%%%%%%%% MITS %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        oed_res.inputs.minlpsol.mits.nint = inputs.exps.n_steps{1};
        oed_res.inputs.minlpsol.mits.acc = 1e-7; % The user has to specify the desired final accuracy
    %               (e.g. 1.0D-7) for the constraints and as a termination criterion
    %               for the local solver.
        oed_res.inputs.minlpsol.mits.maxit = 6e5; % Maximum number of iterations, where one iteration corresponds to
    %               one evaluation of the neighbourhood and maybe an additional
    %               start of the local solver.
        oed_res.inputs.minlpsol.mits.maxun = 500; % The algorithm will stop after the maximum number of consecutive
    %               iterations without improvement has been reached.
        oed_res.inputs.minlpsol.mits.maxtime = 1e5; %  Maximum time for MITS run in seconds.
        oed_res.inputs.minlpsol.mits.maxfun = 6e5; % Maximum number of function evaluations. 
    
end



    %COST FUNCTION
    oed_res.inputs.DOsol.DOcost_type='min';                        %Type of problem: max/min
    oed_res.inputs.DOsol.user_cost = 1;
    oed_res.inputs.DOsol.tf_type='fixed';                          %Process duration type: fixed or free
    oed_res.inputs.DOsol.tf_guess=24*60-180;                               %Process duration

    oed_res.inputs.DOsol.u_interp='stepf';                         %Control definition
                                                           %'sustained' |'stepf'|'step'|'linear'|
    oed_res.inputs.DOsol.n_steps=7;
    oed_res.inputs.DOsol.t_con=0:180:24*60-180;         % Input swithching times, including intial and
                                                               % final times

    switch oed_dat.system
        case "PL"
            % Specify folder name and short_name
            results_folder = strcat('MPLoed',datestr(now,'yyyy-mm-dd'));
            short_name     = strcat('MPLoed_fitation');
            oed_res.inputs.pathd.results_folder = results_folder;                        
            oed_res.inputs.pathd.short_name     = short_name;
            oed_res.inputs.pathd.runident       = 'initial_setup';
            
            y0 = zeros(1,oed_res.inputs.model.n_st);
            y0(1,:) = M3DVSM3D_steady_state(oed_res.inputs.model.par, 0 );  
            oed_res.inputs.DOsol.y0=y0;                               %Initial conditions
            
            oed_res.inputs.DOsol.N_DOcost = 1;
            
            oed_res.inputs.DOsol.u_min= round(0*ones(1,oed_res.inputs.DOsol.n_steps)/oed_dat.dislev);
            oed_res.inputs.DOsol.u_max=round(100*ones(1,oed_res.inputs.DOsol.n_steps)/oed_dat.dislev);% Minimum and maximum value for the input
            
            oed_res.initGuess = round(rand(100,7).*[100*ones(1,oed_res.inputs.DOsol.n_steps)]/oed_dat.dislev);
            
        case "TS"
            % Specify folder name and short_name
            results_folder = strcat('MTSoed',datestr(now,'yyyy-mm-dd'));
            short_name     = strcat('MTSoed_fitation');
            oed_res.inputs.pathd.results_folder = results_folder;                        
            oed_res.inputs.pathd.short_name     = short_name;
            oed_res.inputs.pathd.runident       = 'initial_setup';
            
            % To compute y0
            AMIGO_Prep(oed_res.inputs)
            y0 = zeros(1,oed_res.inputs.model.n_st);
            y0(1,:) = M1vsM2_Compute_SteadyState_OverNight_ModelSelection(oed_res.inputs,oed_res.inputs.model.par,...
                        [28.510, 1363.193, 28.510, 1363.193],...
                        [1, 0]+1e-7);
            oed_res.inputs.DOsol.y0=y0;                               %Initial conditions
            
            oed_res.inputs.DOsol.N_DOcost = 1; % We could make it multi objsective selecting 2?
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%% THIS NEEDS TO BE CHANGED
            %%%%%%%%%%%%%%%%%%%%%%%%%%%% Our platform cannot do this
            oed_res.inputs.DOsol.u_min= [0*ones(1,oed_res.inputs.DOsol.n_steps); 0*ones(1,oed_res.inputs.DOsol.n_steps)]+1e-7;
            oed_res.inputs.DOsol.u_max=[1*ones(1,oed_res.inputs.DOsol.n_steps); 100*ones(1,oed_res.inputs.DOsol.n_steps)];% Minimum and maximum value for the input
            
            
            oed_res.initGuess1 = rand(100,7).*[1*ones(1,oed_res.inputs.DOsol.n_steps)]+1e-7;
            oed_res.initGuess2 = rand(100,7).*[100*ones(1,oed_res.inputs.DOsol.n_steps)]+1e-7;
    
    end
            
        







end

























