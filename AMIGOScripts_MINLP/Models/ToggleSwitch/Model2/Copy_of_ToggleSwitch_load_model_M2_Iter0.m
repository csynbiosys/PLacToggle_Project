function [model] = ToggleSwitch_load_model_M2()

% This script contains the main model structure that we propose for the Toggle Switch
% Amongst the models being considered for model selection, this is Model
% M3.

% model.AMIGOjac = 0;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             
model.n_st=4;                                                               % Number of states      
model.n_par=14;                                                             % Number of model parameters 
model.n_stimulus=2;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('u_IPTG','u_aTc');                                % Name of stimuli or control variables
model.st_names=char('IPTGi','aTci','L_RFP','T_GFP');      % Names of the states                                              
model.par_names=char('k_iptg',...
                     'k_aTc',...
                     'kL_p_m0','kL_p_m','theta_T','theta_aTc','n_aTc','n_T',...
                     'kT_p_m0','kT_p_m','theta_L','theta_IPTG','n_IPTG','n_L');  % Names of the parameters    
                 
model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dIPTGi = k_iptg*(u_IPTG-IPTGi)-0.0165*IPTGi',...
                    'daTci = k_aTc*(u_aTc-aTci)-0.0165*aTci',...
                    'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
                    'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP');
                    

%==================
% PARAMETER VALUES
% =================
% Mean from PE in AMIGO lsq       
model.par=[0.017486759440755,...
           0.011592929618346,...
           0.336522517740871, 5.705484507418318, 19.109506443534496, 0.891542128534452, 1.303415881241293, 3.596924951202656,...
           0.355447150563472, 2.150070441863721, 148.8064428320237, 0.242578510569612, 5.123217357025394, 5.123646005360894];


end                                 