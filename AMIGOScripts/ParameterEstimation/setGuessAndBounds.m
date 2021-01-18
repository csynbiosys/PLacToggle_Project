function [boundperIter] = setGuessAndBounds(fit_res, fit_dat)

    switch fit_dat.iter
        case 1
            if isfile(".\ParameterEstimation\boundperIter.mat")
                load(".\ParameterEstimation\boundperIter.mat","boundperIter");
            else
                boundperIter = {};
                boundperIter.Iter0.PLac1.max = [0.4950,0.4950,4.9,10,0.23,6.8067,0.2449,0.0217,100];
                boundperIter.Iter0.PLac1.min = [3.88e-5,3.88e-2,0.5,2,7.7e-3,0.2433,5.98e-5,0.012,0.01];
                boundperIter.Iter0.PLac1.guess = LHCS(boundperIter.Iter0.PLac1.max, boundperIter.Iter0.PLac1.min);
                
                boundperIter.Iter0.PLac2.max = [0.4950,0.4950,4.9,10,0.23,6.8067,0.2449,0.0217,100];
                boundperIter.Iter0.PLac2.min = [3.88e-5,3.88e-2,0.5,2,7.7e-3,0.2433,5.98e-5,0.012,0.01];
                boundperIter.Iter0.PLac2.guess = LHCS(boundperIter.Iter0.PLac2.max, boundperIter.Iter0.PLac2.min);
                
                boundperIter.Iter0.TS1.max = [0.4488,0.4488,...
                              1.1220,1.1220,...
                              0.3366,112.2018,336.6055,112.2018,5.1250,5.1250,...
                              1.7783,11.2202,336.6055,1.1220,5.1250,5.1250];
                boundperIter.Iter0.TS1.min = [0.0036,0.0036,...
                              0.0089,0.0089,...
                              0.0027,0.8913,2.6738,0.8913,0,0,...
                              0.0056,0.0891,2.6738,0.0089,0,0];
%                 boundperIter.Iter0.TS1.max = [0.4488,0.4488,...
%                               1.1220,1.1220,...
%                               0.3366,112.2018,336.6055,112.2018,5.1250,5.1250,...
%                               1.7783,11.2202,336.6055,1.1220,5.1250,5.1250,...
%                               100,100];
%                 boundperIter.Iter0.TS1.min = [0.0036,0.0036,...
%                               0.0089,0.0089,...
%                               0.0027,0.8913,2.6738,0.8913,0,0,...
%                               0.0056,0.0891,2.6738,0.0089,0,0,...
%                               0.01,0.01];
                boundperIter.Iter0.TS1.guess = LHCS(boundperIter.Iter0.TS1.max, boundperIter.Iter0.TS1.min);          
                          
                boundperIter.Iter0.TS2.max = [0.4488,...
                              1.1220,...
                              0.3366,112.2018,336.6055,112.2018,5.1250,5.1250,...
                              1.7783,11.2202,336.6055,1.1220,5.1250,5.1250];
                boundperIter.Iter0.TS2.min = [0.0036,...
                              0.0089,...
                              0.0027,0.8913,2.6738,0.8913,0,0,...
                              0.0056,0.0891,2.6738,0.0089,0,0];
%                 boundperIter.Iter0.TS2.max = [0.4488,...
%                               1.1220,...
%                               0.3366,112.2018,336.6055,112.2018,5.1250,5.1250,...
%                               1.7783,11.2202,336.6055,1.1220,5.1250,5.1250,...
%                               100,100];
%                 boundperIter.Iter0.TS2.min = [0.0036,...
%                               0.0089,...
%                               0.0027,0.8913,2.6738,0.8913,0,0,...
%                               0.0056,0.0891,2.6738,0.0089,0,0,...
%                               0.01,0.01];
                boundperIter.Iter0.TS2.guess = LHCS(boundperIter.Iter0.TS2.max, boundperIter.Iter0.TS2.min);     

                save(".\ParameterEstimation\boundperIter.mat","boundperIter")
            end
            
        case 2
            load(".\ParameterEstimation\boundperIter.mat","boundperIter");
            
        case 3
            load(".\ParameterEstimation\boundperIter.mat","boundperIter");
            
    end




















end






































