
% Note that this is just a test of the platform since the first set of
% parameters for the model will come from the fit of this data

% Also, only one model is simulated (again, do not trust these results).


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
simul_dat.iter = 0; % Which set of parameters do you want to use (from which iteration of the process). 


simul_res = SimulateExperiments(simul_dat, "PLacIter0TestSimulations");