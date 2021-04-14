function [model] = ToggleSwitch_load_model_M1_Iter0()

% This script contains teh Luggagne model structure proposed for the Toggle Switch
% Amongst the models being considered for model selection, this is Model
% M1.

% model.AMIGOjac = 0;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             
model.n_st=4;                                                               % Number of states      
model.n_par=16;                                                             % Number of model parameters 
model.n_stimulus=2;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('u_IPTG','u_aTc');                                % Name of stimuli or control variables
model.st_names=char('IPTGi','aTci','L_RFP','T_GFP');      % Names of the states                                              
model.par_names=char('k_in_IPTG','k_out_IPTG',...
                     'k_in_aTc','k_out_aTc',...
                     'kL_p_m0','kL_p_m','theta_T','theta_aTc','n_aTc','n_T',...
                     'kT_p_m0','kT_p_m','theta_L','theta_IPTG','n_IPTG','n_L');  % Names of the parameters    
                 
model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dIPTGi = (k_in_IPTG*(u_IPTG-IPTGi)+((k_in_IPTG*(u_IPTG-IPTGi))^2)^0.5)/2-(k_out_IPTG*(IPTGi-u_IPTG)+((k_out_IPTG*(IPTGi-u_IPTG))^2)^0.5)/2',...
                    'daTci = (k_in_aTc*(u_aTc-aTci)+((k_in_aTc*(u_aTc-aTci))^2)^0.5)/2-(k_out_aTc*(aTci-u_aTc)+((k_out_aTc*(aTci-u_aTc))^2)^0.5)/2',...
                    'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
                    'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP');
                    

%==================
% PARAMETER VALUES
% =================
% % Mean from PE in AMIGO lsq
model.par=[0.017330874028137, 0.448799612352708,...
           0.039114902187151, 0.008900001708622,...
           0.091140279001490, 6.587465246253584, 17.254439365949061, 0.891319610677261, 0.913056682378459, 2.969688404397886,...
           0.343908271720810, 1.948644862100263, 192.5106670890757, 0.216070722048464, 5.124980226781978, 5.124987871692474];       


end                                 