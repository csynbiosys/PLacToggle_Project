
%% Simulate Experiments

% This function quickly simulates data for one or many experimetns for both
% systems and a desired model iteration. 
% Inputs: 
%   - simul_dat: structure with 4 fields (mainpath, files, model, iter).
%   See Example_RunExperimentSimulation.m for more details. 
%   - flag: String containing some information about the simulation (also
%   used to not overwrite saved result files). 
%
% Outputs: 
%   - simul_res: Structure with the details of the experiments, input
%   structures for AMIGO and simulation results. 
%   - Plots with the simulations for each experiment will also be generated and
%   saved. 

function [simul_res] = SimulateExperiments(simul_dat, flag)

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
    
    % Check that all the elements in the simula_dat structure are ok
    if length(fields(simul_dat)) ~= 4
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the simul_dat (function input) does not have all the fields.");
        disp("These have to be: mainpath, files, model, iter. All of them must be present.");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    fld = ["mainpath", "files", "model", "iter"];
    for i = 1:4
        if ~isfield(simul_dat, fld(i))
            disp("--------------------------------- WARNING ---------------------------------");
            disp(" ");
            disp("It seems that the simul_dat (function input) does not have all the fields.");
            disp("These have to be: mainpath, files, model, iter. All of them must be present.");
            disp(" ");
            disp("---------------------------------------------------------------------------");
            return
        end
    end
    
    % Check that the contents of the fields are ok. 
    if ~isa(simul_dat.mainpath, 'string') && ~isa(simul_dat.mainpath, 'char')
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field mainpath are wrong.");
        disp("This has to be a string, character or empty string");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(simul_dat.files, 'string') && ~isa(simul_dat.files, 'char')
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field files are wrong.");
        disp("This has to be a list of strings");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(simul_dat.model, 'double') || (simul_dat.model~=0 && simul_dat.model~=1 && simul_dat.model~=2)
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field model are wrong.");
        disp("This has to be 0, 1 or 2");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
    
    if ~isa(simul_dat.iter, 'double') || (simul_dat.iter~=0 && simul_dat.iter~=1 && simul_dat.iter~=2 && simul_dat.iter~=3)
        disp("--------------------------------- WARNING ---------------------------------");
        disp(" ");
        disp("It seems that the contents of the field iter are wrong.");
        disp("This has to be 0, 1, 2, 3");
        disp(" ");
        disp("---------------------------------------------------------------------------");
        return
    end
     
    %%
    % Check that the file with the experiment data exists and if so, load
    % them and fill the results structure with the details of the
    % experiment. 
    
    % Everything containing PS refers to PLac and containing TS to  Toggle
    % Switch. 
    simul_res = {};
    simul_res.expsPL = {}; % This will contain the detains of the experiment and data extracted from the CSV (makes plotting easier)
    simul_res.expsTS = {};
    simul_res.inputsPL = {}; % This will contain the inputs structure for AMIGO
    simul_res.inputsTS = {};
    countPL = 0; % Necessary in case the user wants the simulations of the two systems. 
    countTS = 0;
    
    %%
    for i = 1:length(simul_dat.files)
        
        % First check that the file exists
        if simul_dat.mainpath == "" || simul_dat.mainpath == ''
            datpat = strjoin(([simul_dat.files(i)]), "");
        else
            datpat = strjoin(([simul_dat.mainpath, '\\', simul_dat.files(i)]), "");
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
        
        % Load the CSV file
        try
            tmp1 = readmatrix(datpat);
        catch
            tmp1 = csvread(datpat,1);
        end
        
        % This checks if the data introduced is from PLac or Toggle Switch
        [~,b] = size(tmp1);
        
        if b == 5 || b == 6
            countPL = countPL+1;
            % Extract all information from CSV for the experiment
            simul_res.expsPL{countPL}.preIPTG = tmp1(1,1);
            simul_res.expsPL{countPL}.time = tmp1(:,3);
            simul_res.expsPL{countPL}.IPTGfull = tmp1(:,2);
            simul_res.expsPL{countPL}.CitrineMean = tmp1(:,4);
            simul_res.expsPL{countPL}.CitrineSD = tmp1(:,5);
            
            % Put inputs information in events. 
            simul_res = wrapInputDetails(simul_res, countPL, "PL");   
            
        else
            countTS = countTS+1;            
            simul_res.expsTS{countTS}.preIPTG = tmp1(1,1);
            simul_res.expsTS{countTS}.preaTc = tmp1(1,2);
            simul_res.expsTS{countTS}.time = tmp1(:,5);
            simul_res.expsTS{countTS}.IPTGfull = tmp1(:,3);
            simul_res.expsTS{countTS}.aTcfull = tmp1(:,4);
            simul_res.expsTS{countTS}.RFPMean = tmp1(:,6);
            simul_res.expsTS{countTS}.RFPSD = tmp1(:,7);
            simul_res.expsTS{countTS}.GFPMean = tmp1(:,8);
            simul_res.expsTS{countTS}.GFPSD = tmp1(:,9);
            
            simul_res = wrapInputDetails(simul_res, countTS, "TS");
            
            
        end
    end
    
    %%
    % Generate the inputs structure for AMIGO for both systems. 
    simul_res = setAMIGOStructureSimul(simul_res, simul_dat, countPL, countTS);
    
    %%
    % Run Simulations, and save results
    % PLac
    if countPL ~= 0
        AMIGO_Prep(simul_res.inputsPL)
        simPL = AMIGO_SModel(simul_res.inputsPL);
        simul_res.resultsPL = simPL;
    end
    % Toggle Switch
    if countTS ~= 0
        AMIGO_Prep(simul_res.inputsTS)
        simTS = AMIGO_SModel(simul_res.inputsTS);
        simul_res.resultsTS = simTS;
    end

    save(strjoin([".\Results\SimulationResults_", date, "_", flag, ".mat"],""), "simul_res", "simul_dat")
    
    %% Plot results (this will get saved too)
    
    % Plac
    if countPL ~= 0
        for i =1:countPL
            h = figure;
            subplot(4,1,1:3)
            hold on
%             errorbar(simul_res.expsPL{i}.time, simul_res.expsPL{i}.CitrineMean, simul_res.expsPL{i}.CitrineSD, 'black')
            switch simul_dat.model
                case 0
                    plot(simul_res.resultsPL.sim.tsim{i}, simul_res.resultsPL.sim.states{i}(:,4), 'g')
                    plot(simul_res.resultsPL.sim.tsim{i}, simul_res.resultsPL.sim.states{i}(:,8), 'c')
                    legend('Data', 'Model 1','Model 2')
                    title(strjoin(["PLac Simulation Model 1 VS Model 2, iteration ", num2str(simul_dat.iter)], ""))
                case {1,2}
                    plot(simul_res.resultsPL.sim.tsim{i}, simul_res.resultsPL.sim.states{i}(:,4), 'g')
                    legend('Data', strjoin(["Model ", num2str(simul_dat.model)], ""))
                    title(strjoin(["PLac Simulation Model ",  num2str(simul_dat.model), ", iteration ", num2str(simul_dat.iter)], ""))
            end
            ylabel('Citrine (A.U.)')
            
            subplot(4,1,4)
            hold on
            stairs(simul_res.expsPL{i}.time, simul_res.expsPL{i}.IPTGfull, 'b')
            ylabel('IPTG (mM)')
            xlabel('time(min)')
            saveas(h, strjoin([".\Results\SimuPlot_PLacExp",num2str(i), "_", date(), "Model", ...
                num2str(simul_dat.model),"_Iter", num2str(simul_dat.iter), "_", flag,".png"], ""))
        end
    end
    
    % Toggle Switch
    if countTS ~= 0
        for i =1:countTS
            g = figure;
            subplot(6,1,1:2)
            hold on
            errorbar(simul_res.expsTS{i}.time, simul_res.expsTS{i}.RFPMean, simul_res.expsTS{i}.RFPSD, 'black')
            switch simul_dat.model
                case 0
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,3), 'r')
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,7), 'c')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,5), 'r')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,11), 'c')
                    legend('Data', 'Model 1','Model 2')
                    title(strjoin(["Toggle Switch Simulation Model 1 VS Model 2, iteration ", num2str(simul_dat.iter)], ""))
                case {1,2}
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,3), 'r')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,5), 'r')

                    legend('Data', strjoin(["Model ", num2str(simul_dat.model)], ""))
                    title(strjoin(["Toggle Switch Simulation Model ",  num2str(simul_dat.model), ", iteration ", num2str(simul_dat.iter)], ""))
            end
            ylabel('RFP (A.U.)')
            
            
            subplot(6,1,3:4)
            hold on
            errorbar(simul_res.expsTS{i}.time, simul_res.expsTS{i}.GFPMean, simul_res.expsTS{i}.GFPSD, 'black')
            switch simul_dat.model
                case 0
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,4), 'g')
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,8), 'c')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,6), 'r')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,12), 'c')
                    legend('Data', 'Model 1','Model 2')
                case {1,2}
                    plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,4), 'g')
%                     plot(simul_res.resultsTS.sim.tsim{i}, simul_res.resultsTS.sim.states{i}(:,6), 'r')
                    legend('Data', strjoin(["Model ", num2str(simul_dat.model)], ""))
            end
            ylabel('GFP (A.U.)')
            
            
            subplot(6,1,5)
            hold on
            stairs(simul_res.expsTS{i}.time, simul_res.expsTS{i}.IPTGfull, 'b')
            ylabel('IPTG (mM)')
            
            subplot(6,1,6)
            hold on
            stairs(simul_res.expsTS{i}.time, simul_res.expsTS{i}.aTcfull, 'm')
            ylabel('aTc (ng/ml)')
            xlabel('time(min)')
            
            saveas(g, strjoin([".\Results\SimPlot_ToggleExp",num2str(i), "_", date(), "Model", ...
                num2str(simul_dat.model),"_Iter", num2str(simul_dat.iter), "_", flag,".png"], ""))
        end
        
    end
    
end

    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
           
            
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    