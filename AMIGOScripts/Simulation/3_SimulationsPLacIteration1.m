
% This script simulates the model against the initial data used to perform
% the first calibration of the models. 
% Here we compare both models against all the data for the current
% iteration. 


%% Model 1
simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Initial"; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
simul_dat.files = ["12-Dec-2020_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG-Corrected_Average_Data_saturation.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG-Corrected_Average_Data.csv", "17-Dec-2020_Random-Corrected_Average_Data.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
simul_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna be or
                     % 0 if you want both. 
simul_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 


simul_res = SimulateExperiments(simul_dat, "PLac_Model1_Iter1_AllSimulations");


%% Model 2

simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Initial"; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
simul_dat.files = ["12-Dec-2020_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG-Corrected_Average_Data_saturation.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG-Corrected_Average_Data.csv", "17-Dec-2020_Random-Corrected_Average_Data.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
simul_dat.model = 2; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna be or
                     % 0 if you want both. 
simul_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 


simul_res = SimulateExperiments(simul_dat, "PLac_Model1_Iter2_AllSimulations");

















