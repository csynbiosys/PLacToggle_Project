
% First we need an empty structure with the 4 following fields
% (compulsory). 
% You do not need to indicate which of the 2 models you want to simulate since
% that information can be extracted from the data file. 

%%
simul_dat = {};
simul_dat.mainpath = ""; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
simul_dat.files = ["PLacTest.csv", "ToggleTest.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
simul_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna be or
                     % 0 if you want both. 
simul_dat.iter = 0; % Which set of parameters do you want to use (from which iteration of the process). 


simul_res = SimulateExperiments(simul_dat, "test1");



%%
simul_dat = {};
simul_dat.mainpath = ""; 
simul_dat.files = ["PLacTest.csv", "ToggleTest.csv"]; 
simul_dat.model = 2; 
simul_dat.iter = 0;
simul_res = SimulateExperiments(simul_dat, "test2");


%%
simul_dat = {};
simul_dat.mainpath = ""; 
simul_dat.files = ["PLacTest.csv", "ToggleTest.csv"]; 
simul_dat.model = 0; 
simul_dat.iter = 0;
simul_res = SimulateExperiments(simul_dat, "test3");



%%
simul_dat = {};
simul_dat.mainpath = ""; 
simul_dat.files = ["PLacTest.csv", "ToggleTest.csv"]; 
simul_dat.model = 1; 
simul_dat.iter = 2;
simul_res = SimulateExperiments(simul_dat, "test4");
















