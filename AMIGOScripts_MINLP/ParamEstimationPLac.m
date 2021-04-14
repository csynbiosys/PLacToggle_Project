
% This model contains the necessary structures to run any of the PLac
% parameter estimations (all models and iterations). This is the script used in the
% study to fit the PLac model for different experimental datasets. 

StartUpModels();

%% Fit 1, Model 1, Data Iteration 0

% This is the first fit performed for model 1 of PLac from non optimised
% data (iteration 0). In this particular case step data. 

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

fit_res = FitModels(fit_dat, "PLac_Model1_Step_Iter1_PE");

%% Fit 1, Model 2, Data Iteration 0

% This is the first fit performed for model 2 of PLac from non optimised
% data (iteration 0). In this particular case random data. 

fit_dat = {};
fit_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Initial";
fit_dat.files = ["17-Dec-2020_Random-Corrected_Average_Data.csv"];
fit_dat.model = 1; 
fit_dat.iter = 1; 

fit_res = FitModels(fit_dat, "PLac_Model2_Random_Iter1_PE");










