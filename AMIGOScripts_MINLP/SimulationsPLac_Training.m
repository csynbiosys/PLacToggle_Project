
% This model contains the necessary structures to run any of the PLac
% simulations (all models and iterations). This is the script used in the
% study to simulate the PLac model for different experimental conditions. 

StartUpModels();

%% Iteration 0, No Fit

% Note that this is just a test of the platform since the first set of
% parameters for the model will come from the fit of this data

% Also, only one model is simulated (again, do not trust these results).


simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Corrected"; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
simul_dat.files = ["11-Mar-2021_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG_corrected.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG_corrected.csv", ...
                    "17-Dec-2020_Random_corrected.csv", "19-Feb-2021_Step_100uMIPTG_Repeat_CorrectBackground_corrected.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
simul_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna be or
                     % 0 if you want both. 
simul_dat.iter = 0; % Which set of parameters do you want to use (from which iteration of the process). 


simul_res0 = SimulateExperiments(simul_dat, "PLacIter0TrainingSet");


%% Iteration 1, Model 1
simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Corrected"; 
simul_dat.files = ["11-Mar-2021_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG_corrected.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG_corrected.csv", ...
                    "17-Dec-2020_Random_corrected.csv", "19-Feb-2021_Step_100uMIPTG_Repeat_CorrectBackground_corrected.csv"]; 
simul_dat.model = 1; 
simul_dat.iter = 1; 
simul_res11 = SimulateExperiments(simul_dat, "PLacIter1Model1TrainingSet");


%% Iteration 1, Model 2
simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Corrected"; 
simul_dat.files = ["11-Mar-2021_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG_corrected.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG_corrected.csv", ...
                    "17-Dec-2020_Random_corrected.csv", "19-Feb-2021_Step_100uMIPTG_Repeat_CorrectBackground_corrected.csv"]; 
simul_dat.model = 2; 
simul_dat.iter = 1; 
simul_res12 = SimulateExperiments(simul_dat, "PLacIter1Model2TrainingSet");


%% Iteration 2, Model 1
simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Corrected"; 
simul_dat.files = ["11-Mar-2021_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG_corrected.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG_corrected.csv", ...
                    "17-Dec-2020_Random_corrected.csv", "19-Feb-2021_Step_100uMIPTG_Repeat_CorrectBackground_corrected.csv"]; 
simul_dat.model = 1; 
simul_dat.iter = 2; 
simul_res21 = SimulateExperiments(simul_dat, "PLacIter2Model1TrainingSet");

%% Iteration 2, Model 2
simul_dat = {};
simul_dat.mainpath = "..\ExperimentsCsvFiles\PLac_Corrected"; 
simul_dat.files = ["11-Mar-2021_Step_100uMIPTG-Corrected_Average_Data.csv", "13-Dec-2020_Step_7p5uMIPTG_corrected.csv", ...
                    "16-Dec-2020_Step_2p5uMIPTG_corrected.csv", ...
                    "17-Dec-2020_Random_corrected.csv", "19-Feb-2021_Step_100uMIPTG_Repeat_CorrectBackground_corrected.csv"]; 
simul_dat.model = 2; 
simul_dat.iter = 2; 
simul_res22 = SimulateExperiments(simul_dat, "PLacIter2Model2TrainingSet");




















