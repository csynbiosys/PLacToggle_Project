
%% Fit Models

% This function quickly starts Parameter Estimation for a specified system,
% model iteration and set of data using AMIGO. 
%
% Inputs: 
%   - fit_dat: structure with 4 fields (mainpath, files, model, iter).
%   See ExampleFitModelsWithData.m for more details. 
%   - flag: String containing some information about the fit (also
%   used to not overwrite saved result files). 
%
% Outputs: 
%   - fit_res: structure containing the results of the PE. As fiels you
%   should have exps (experimetnal data from the CSV), inputs (AMIGO
%   structure for the PE), system (string indicating if the PE was done for
%   PLac or Toggle Switch), global_theta_guess (matrix with the initial
%   guesses used for the PE), results (AMIGO results for each run),
%   bestRun(the run with better cost function value) and bestRunIndx(index
%   of fit_res.results corresponding to the best run). 
%   - Plots with the simulations for each experiment will also be generated and
%   saved. 

function [fit_res] = FitModels(fit_dat, flag)

    if ~isfolder(".\Results")
        mkdir(".\Results")
    end

    % Check that AMIGO is included in the path
    if exist('AMIGO_Prep', 'file') == 0
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that AMIGO is not in the working path! Please, include it before proceeding.");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end

    % Check that all the elements in the fit_dat structure are ok
    if length(fields(fit_dat)) ~= 4
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the fit_dat (function input) does not have all the fields.");
        disp("These have to be: mainpath, files, model, iter. All of them must be present.");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    fld = ["mainpath", "files", "model", "iter"];
    for i = 1:4
        if ~isfield(fit_dat, fld(i))
            disp("--------------------------------- WARNING ---------------------------------");
            disp(" ");
            disp("It seems that the fit_dat (function input) does not have all the fields.");
            disp("These have to be: mainpath, files, model, iter. All of them must be present.");
            disp(" ");
            disp("---------------------------------------------------------------------------");
            return
        end
    end

    % Check that the contents of the fields are ok. 
    if ~isa(fit_dat.mainpath, 'string') && ~isa(fit_dat.mainpath, 'char')
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field mainpath are wrong.");
        disp("This has to be a string, character or empty string");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(fit_dat.files, 'string') && ~isa(fit_dat.files, 'char')
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field files are wrong.");
        disp("This has to be a list of strings");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(fit_dat.model, 'double') || (fit_dat.model~=1 && fit_dat.model~=2)
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field model are wrong.");
        disp("This has to be 1 or 2");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(fit_dat.iter, 'double') || (fit_dat.iter~=1 && fit_dat.iter~=2 && fit_dat.iter~=3)
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field iter are wrong.");
        disp("This has to be 1, 2, 3");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    %%
    % Check that the file with the experiment data exists and if so, load
    % them and fill the results structure with the details of the
    % experiment. 
    % Fit for only one of the systems will be allowed, so check taht all
    % the data given is from the same system will be done. 
    
    fit_res = {};
    fit_res.exps = {}; % This will contain the detains of the experiment and data extracted from the CSV (makes plotting easier)
    fit_res.inputs = {}; % This will contain the inputs structure for AMIGO
    
    % First we loop to check that all the files exist and that they all
    % come from the same system. 
    dat = cell(1,1); % This is so the first experiment data gets saved and can be used to check that all files come from the same system. 
    for i = 1:length(fit_dat.files)
        
        % First check that the file exists
        if fit_dat.mainpath == "" || fit_dat.mainpath == ''
            datpat = strjoin(([fit_dat.files(i)]), "");
        else
            datpat = strjoin(([fit_dat.mainpath, '\\', fit_dat.files(i)]), "");
        end
        if ~isfile(datpat)
            disp("--------------------------------- WARNING ---------------------------------");
            disp(" ");
            disp("It seems that there is something wrong with the files introduced.");
            disp("Remember that the field files has to be a list of strings and that each file string needs to contain the termination .csv");
            disp(strcat("The issue happened in file number ", num2str(i)));
            disp(" ");
            disp("---------------------------------------------------------------------------");
            return
        end
        
        % Load the CSV file and introduce it in the data structure. 
        try
            tmp1 = readmatrix(datpat);
        catch
            tmp1 = csvread(datpat,1);
        end
        if i == 1
            dat{1} = tmp1;
        else
            [~,b] = size(dat{1});
            [~,d] = size(tmp1);
            if b ~= d
                disp("--------------------------------- WARNING ---------------------------------");
                disp(" ");
                disp("It seems that there is something wrong with the files introduced.");
                disp("You have introduced data for PLac and Toggle Switch and this is not allowed in this section.");
                disp("Please, give data for only one of the two systems to perform the fit for it.");
                disp(" ");
                disp("---------------------------------------------------------------------------");
                return
            end
        end
        
        % This checks if the data introduced is from PLac or Toggle Switch
        [~,b] = size(tmp1);
        
        if b == 5 || b == 6
            % Extract all information from CSV for the experiment
            fit_res.exps{i}.preIPTG = tmp1(1,1);
            fit_res.exps{i}.time = tmp1(:,3);
            fit_res.exps{i}.IPTGfull = tmp1(:,2);
            fit_res.exps{i}.CitrineMean = tmp1(:,4);
            fit_res.exps{i}.CitrineSD = tmp1(:,5);
            
            % Put inputs information in events. 
            fit_res = wrapInputDetailsFit(fit_res, i, "PL");  
            fit_res.system = "PL";
        else
            fit_res.exps{i}.preIPTG = tmp1(1,1);
            fit_res.exps{i}.preaTc = tmp1(1,2);
            fit_res.exps{i}.time = tmp1(:,5);
            fit_res.exps{i}.IPTGfull = tmp1(:,3);
            fit_res.exps{i}.aTcfull = tmp1(:,4);
            fit_res.exps{i}.RFPMean = tmp1(:,6);
            fit_res.exps{i}.RFPSD = tmp1(:,7);
            fit_res.exps{i}.GFPMean = tmp1(:,8);
            fit_res.exps{i}.GFPSD = tmp1(:,9);
            
            fit_res = wrapInputDetailsFit(fit_res, i, "TS");
            fit_res.system = "TS";
        end
    end
    
    %% 
    % Generate the inputs structure for AMIGO for the system. 
    fit_res = setAMIGOStructureFit(fit_res, fit_dat);

    % Run PE in a parfor for each initial guess
    if ~isfolder(strjoin([".\Results\PE_", fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter, "_", flag], ""))
        mkdir(strjoin([".\Results\PE_", fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter, "_", flag], ""))
    end
    
    [k,~] = size(fit_res.global_theta_guess);
    tmpmat = fit_res.global_theta_guess;
    results = cell(1,100);
    
%     fit_res.inputs.nlpsol.eSS.maxeval = 200;
%     fit_res.inputs.nlpsol.eSS.maxtime = 100;
%     k = 2;

    if isfile(strjoin([".\Results\PEResults_",fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter,"_", date, "_", flag, ".mat"],""))
        tmp1 = load(strjoin([".\Results\PEResults_",fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter,"_", date, "_", flag, ".mat"],""));
        results = tmp1.fit_res.results;
    end

    AMIGO_Prep(fit_res.inputs);
    parfor j=1:k
%     for j=1:2    
        try
            if isempty(results{j})
                tmpth = tmpmat(j,:);
                peRes = mainRunPE(fit_res, fit_dat, flag, tmpth, j);
                results{j} = peRes;
            end
        catch
        end
    end
    
    fit_res.results = results; 
    
    %% Select best run by comparing cost function values
    cfv = zeros(1,k)+1e200;
    for j=1:k
        try
            if isreal(sum(fit_res.results{j}.fit.conf_interval))
                cfv(j) = fit_res.results{j}.nlpsol.fbest; 
            end
        catch
        end
    end
    bcfv = min(cfv);
    bind = find(cfv==bcfv(1));
    
    fit_res.bestRun = fit_res.results{bind};
    fit_res.bestRunIndx = bind; 
    
    
    
    %% Plot Best results and convergence curve       
            
    inputs = {};
    inputs.model = fit_res.inputs.model;
    inputs.model.par = fit_res.bestRun.fit.thetabest'; 
    inputs.pathd = fit_res.inputs.pathd;
    inputs.exps = fit_res.inputs.exps;
    inputs.ivpsol = fit_res.inputs.ivpsol;
    inputs.plotd = fit_res.inputs.plotd;
    
    fit_res.bestSimul = cell(1,fit_res.inputs.exps.n_exp);
    
%     AMIGO_Prep(inputs);
    
    % Best simulations against data
    
    % Separate loop so AMIGO does not close the plots in a loop
    for i = 1:fit_res.inputs.exps.n_exp
        switch fit_res.system
            case "PL"
                inputs.exps.exp_y0{i}=M3D_steady_state(inputs.model.par, fit_res.exps{i}.preIPTG);
                simbestres = AMIGO_SModel_NoVer(inputs);
                fit_res.bestSimul{i} = simbestres;
            case "TS"
                
        end
    end
    
    for i = 1:fit_res.inputs.exps.n_exp
              
        switch fit_res.system
            case "PL"

                h = figure(i);  
                subplot(4,1,1:3)
                hold on
                errorbar(fit_res.exps{i}.time, fit_res.exps{i}.CitrineMean, fit_res.exps{i}.CitrineSD, 'black')
                plot(fit_res.bestSimul{i}.sim.tsim{i}, fit_res.bestSimul{i}.sim.states{i}(:,4), 'g')
                title(strjoin(["PLac Best Theta Simulation Model ",  num2str(fit_dat.model), ", iteration ", num2str(fit_dat.iter)], ""))
                ylabel('Citrine (A.U.)')

                subplot(4,1,4)
                hold on
                stairs(fit_res.exps{i}.time, fit_res.exps{i}.IPTGfull, 'b')
                ylabel('IPTG (mM)')
                xlabel('time(min)')
                saveas(h, strjoin([".\Results\PE_BestPlot_PLacExp",num2str(i), "_", date(), "Model", ...
                    num2str(fit_dat.model),"_Iter", num2str(fit_dat.iter), "_", flag,".png"], ""))
                hold off
            case "TS"
                switch fit_dat.model
                    case 1
                        inputs.exps.exp_y0{i}=M1_Compute_SteadyState_OverNight(inputs,...
                            inputs.model.par,[fit_res.exps{i}.RFPMean(1), fit_res.exps{i}.GFPMean(1)],...
                            [fit_res.exps{i}.preIPTG, fit_res.exps{i}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{i}=M1SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{i}.RFPMean(1), fit_res.exps{i}.GFPMean(1)],...
        %                     [fit_res.exps{i}.preIPTG, fit_res.exps{i}.preaTc]+1e-7);
                    case 2
                        inputs.exps.exp_y0{i}=M2_Compute_SteadyState_OverNight(inputs,...
                            inputs.model.par,[fit_res.exps{i}.RFPMean(1), fit_res.exps{i}.GFPMean(1)],...
                            [fit_res.exps{i}.preIPTG, fit_res.exps{i}.preaTc]+1e-7);
        %                 fit_res.inputs.exps.exp_y0{i}=M2SF_Compute_SteadyState_OverNight(fit_res.inputs,...
        %                     fit_res.inputs.model.par,[fit_res.exps{i}.RFPMean(1), fit_res.exps{i}.GFPMean(1)],...
        %                     [fit_res.exps{i}.preIPTG, fit_res.exps{i}.preaTc]+1e-7);
                end
                simbestres = AMIGO_SModel_NoVer(inputs);
                fit_res.bestSimul{i} = simbestres;
                
                h = figure;
                subplot(6,1,1:2)
                hold on
                errorbar(fit_res.exps{i}.time, fit_res.exps{i}.RFPMean, fit_res.exps{i}.RFPSD, 'black')
                plot(simbestres.sim.tsim{i}, simbestres.sim.states{i}(:,3), 'r')
%                     plot(simbestres.sim.tsim{i}, simbestres.sim.states{i}(:,5), 'r')
                title(strjoin(["Toggle Switch Best Theta Simulation Model ",  num2str(fit_dat.model), ", iteration ", num2str(fit_dat.iter)], ""))
                ylabel('RFP (A.U.)')

                subplot(6,1,3:4)
                hold on
                errorbar(fit_res.exps{i}.time, fit_res.exps{i}.GFPMean, fit_res.exps{i}.GFPSD, 'black')
                plot(simbestres.sim.tsim{i}, simbestres.sim.states{i}(:,4), 'g')
%                     plot(simbestres.sim.tsim{i}, simbestres.sim.states{i}(:,6), 'g')
                ylabel('GFP (A.U.)')


                subplot(6,1,5)
                hold on
                stairs(fit_res.exps{i}.time, fit_res.exps{i}.IPTGfull, 'b')
                ylabel('IPTG (mM)')

                subplot(6,1,6)
                hold on
                stairs(fit_res.exps{i}.time, fit_res.exps{i}.aTcfull, 'm')
                ylabel('aTc (ng/ml)')
                xlabel('time(min)')

                saveas(h, strjoin([".\Results\PE_BestPlot_ToggleExp",num2str(i), "_", date(), "Model", ...
                    num2str(fit_dat.model),"_Iter", num2str(fit_dat.iter), "_", flag,".png"], ""))
        end
        
    end
    
    % Convergence Curve
    cc = figure();
    hold on 
    for j=1:k
        try
            stairs(fit_res.results{j}.nlpsol.neval, fit_res.results{j}.nlpsol.f);
        catch
        end
    end
    xlabel("Function Evalueation");
    ylabel("f")
    title(strjoin(["Cost Function ", fit_res.system, " Model ", fit_dat.model, ", IterGen ", fit_dat.iter], ""))
    saveas(cc, strjoin([".\Results\PE_ConvergencePlot_",fit_res.system, "_", date(), "Model", ...
                num2str(fit_dat.model),"_Iter", num2str(fit_dat.iter), "_", flag,".png"], ""))
            
    save(strjoin([".\Results\PEResults_",fit_res.system, "_Model", fit_dat.model, "_GenIter", fit_dat.iter,"_", date, "_", flag, ".mat"],""), "fit_res", "fit_dat")
        
    %% Generate the script with the new theta values
    genModelscript(fit_res, fit_dat);
    
    %% Update Bounds for model (and matrix of initial guesses)
    
    % Get best theta and compute new bounds with the confidence intervals
    % from AMIGO
    bestN = fit_res.bestRun.fit.thetabest';
    maxN = bestN + fit_res.bestRun.fit.conf_interval;
    minN = bestN - fit_res.bestRun.fit.conf_interval;
    
    load(".\ParameterEstimation\boundperIter.mat","boundperIter");
    
    
    
    
    switch fit_res.system
        case "PL"
            
            for j=1:length(minN)
                if maxN(j) > boundperIter.Iter0.PLac1.max(j)
                    maxN(j) = boundperIter.Iter0.PLac1.max(j);
                end
                if minN(j) < boundperIter.Iter0.PLac1.min(j)
                    minN(j) = boundperIter.Iter0.PLac1.min(j);
                end
            end
            switch fit_dat.model
                case 1
                    switch fit_dat.iter
                        case 1
                            boundperIter.Iter1.PLac1.max = maxN;
                            boundperIter.Iter1.PLac1.min = minN;
                            boundperIter.Iter1.PLac1.guess = LHCS(boundperIter.Iter1.PLac1.max, boundperIter.Iter1.PLac1.min);
                        case 2
                            boundperIter.Iter2.PLac1.max = maxN;
                            boundperIter.Iter2.PLac1.min = minN;
                            boundperIter.Iter2.PLac1.guess = LHCS(boundperIter.Iter2.PLac1.max, boundperIter.Iter2.PLac1.min);
                        case 3
                            boundperIter.Iter3.PLac1.max = maxN;
                            boundperIter.Iter3.PLac1.min = minN;
                            boundperIter.Iter3.PLac1.guess = LHCS(boundperIter.Iter3.PLac1.max, boundperIter.Iter3.PLac1.min);
                    end
                case 2
                    switch fit_dat.iter
                        case 1
                            boundperIter.Iter1.PLac2.max = maxN;
                            boundperIter.Iter1.PLac2.min = minN;
                            boundperIter.Iter1.PLac2.guess = LHCS(boundperIter.Iter1.PLac2.max, boundperIter.Iter1.PLac2.min);
                        case 2
                            boundperIter.Iter2.PLac2.max = maxN;
                            boundperIter.Iter2.PLac2.min = minN;
                            boundperIter.Iter2.PLac2.guess = LHCS(boundperIter.Iter2.PLac2.max, boundperIter.Iter2.PLac2.min);
                        case 3
                            boundperIter.Iter3.PLac2.max = maxN;
                            boundperIter.Iter3.PLac2.min = minN;
                            boundperIter.Iter3.PLac2.guess = LHCS(boundperIter.Iter3.PLac2.max, boundperIter.Iter3.PLac2.min);
                    end
            end
        case "TS"
            switch fit_dat.model
                case 1
                    switch fit_dat.iter
                        case 1
                            boundperIter.Iter1.TS1.max = maxN;
                            boundperIter.Iter1.TS1.min = minN;
                            boundperIter.Iter1.TS1.guess = LHCS(boundperIter.Iter1.TS1.max, boundperIter.Iter1.TS1.min);
                        case 2
                            boundperIter.Iter2.TS1.max = maxN;
                            boundperIter.Iter2.TS1.min = minN;
                            boundperIter.Iter2.TS1.guess = LHCS(boundperIter.Iter2.TS1.max, boundperIter.Iter2.TS1.min);
                        case 3
                            boundperIter.Iter3.TS1.max = maxN;
                            boundperIter.Iter3.TS1.min = minN;
                            boundperIter.Iter3.TS1.guess = LHCS(boundperIter.Iter3.TS1.max, boundperIter.Iter3.TS1.min);
                    end
                case 2
                    switch fit_dat.iter
                        case 1
                            boundperIter.Iter1.TS2.max = maxN;
                            boundperIter.Iter1.TS2.min = minN;
                            boundperIter.Iter1.TS2.guess = LHCS(boundperIter.Iter1.TS2.max, boundperIter.Iter1.TS2.min);
                        case 2
                            boundperIter.Iter2.TS2.max = maxN;
                            boundperIter.Iter2.TS2.min = minN;
                            boundperIter.Iter2.TS2.guess = LHCS(boundperIter.Iter2.TS2.max, boundperIter.Iter2.TS2.min);
                        case 3
                            boundperIter.Iter3.TS2.max = maxN;
                            boundperIter.Iter3.TS2.min = minN;
                            boundperIter.Iter3.TS2.guess = LHCS(boundperIter.Iter3.TS2.max, boundperIter.Iter3.TS2.min);
                    end
            end
    end
    save(".\ParameterEstimation\boundperIter.mat","boundperIter");
    
    
end























