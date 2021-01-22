
% First we need an empty structure with the 4 following fields
% (compulsory). 
% You do not need to indicate which of the 2 models you want to simulate since
% that information can be extracted from the data file. 

%%
fit_dat = {};
fit_dat.mainpath = ""; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
fit_dat.files = ["PLacTest.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
fit_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna. 
fit_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 
                  % This flag indicates from what fit iteration it is going to be the current fit (and hence
                  % it will use the theta guess from the previous
                  % iteration) so only 1, 2 and 3 are accetable values. 

fit_res = FitModels(fit_dat, "test1");



%%
fit_dat = {};
fit_dat.mainpath = ""; % String with the main path to the directory where the file to be used is. If you are in the directory
                         % or this is in the path or there are different
                         % directories you can just give an empty string. 
fit_dat.files = ["ToggleTest.csv"]; 
                      % List of strings with the name of the files containing the experimental data and details. 
                      % If files are located in different folders you can
                      % just introduce the full path for each one of them. 
fit_dat.model = 1; % From each of the models we work we are gonna be using 2 variants (2 for PLac and 2 for Toggle Switch). 
                     % Select 1 or 2 to indicate wich one is it gonna. 
fit_dat.iter = 1; % Which set of parameters do you want to use (from which iteration of the process). 
                  % This flag indicates from what fit iteration it is going to be the current fit (and hence
                  % it will use the theta guess from the previous
                  % iteration) so only 1, 2 and 3 are accetable values. 

fit_res = FitModels(fit_dat, "test2");












