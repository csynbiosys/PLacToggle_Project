
% This script performs parameter estimation for Model 1 and 2 (in series) of PLac with the
% first initial data to obtain the inital parameter set for the model. 

%% Model 1, PE 1

fit_dat = {};
fit_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Initial"; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
fit_dat.files = ["12-Dec-2020_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG-Corrected_Average_Data_saturation.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG-Corrected_Average_Data.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
fit_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna. 
fit_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 
                  % This flag indicates from what fit iteration it is going to be the current fit (and hence
                  % it will use the theta guess from the previous
                  % iteration) so only 1, 2 and 3 are accetable values. 

fit_res = FitModels(fit_dat, "PLac_Model1_Iter1_PE");

%% Model 2, PE 1

fit_dat = {};
fit_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Initial"; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
fit_dat.files = ["17-Dec-2020_Random-Corrected_Average_Data.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
fit_dat.model = 2; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna. 
fit_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 
                  % This flag indicates from what fit iteration it is going to be the current fit (and hence
                  % it will use the theta guess from the previous
                  % iteration) so only 1, 2 and 3 are accetable values. 

fit_res = FitModels(fit_dat, "PLac_Model1_Iter1_PE");


