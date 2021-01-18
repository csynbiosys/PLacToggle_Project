function [model] = ToggleSwitch_load_model_M1vsM2_ModelSelection()

% This script contains the model structures 1 (Lugagne) and 3 (ours) for the Toggle Switch
% toghether for OED purposes. 

% model.AMIGOjac = 0;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             
model.n_st=8;                                                               % Number of states      
model.n_par=30;                                                             % Number of model parameters 
model.n_stimulus=2;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('u_IPTG','u_aTc');                                % Name of stimuli or control variables
model.st_names=char('IPTGi', 'aTci', 'L_RFP', 'T_GFP',...
'IPTGi2','aTci2','L_RFP2','T_GFP2');      % Names of the states    

model.par_names=char('k_in_IPTG','k_out_IPTG',...
'k_in_aTc','k_out_aTc',...
'kL_p_m0', 'kL_p_m', 'theta_T', 'theta_aTc', 'n_aTc', 'n_T',...
'kT_p_m0', 'kT_p_m', 'theta_L', 'theta_IPTG','n_IPTG','n_L',...
...
'k_iptg2',...
'k_aTc2',...
'kL_p_m02','kL_p_m2','theta_T2','theta_aTc2', 'n_aTc2', 'n_T2',...
'kT_p_m02','kT_p_m2','theta_L2','theta_IPTG2','n_IPTG2','n_L2');                                  % Names of the parameters    

model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
char('dIPTGi = (k_in_IPTG*(u_IPTG-IPTGi)+((k_in_IPTG*(u_IPTG-IPTGi))^2)^0.5)/2-(k_out_IPTG*(IPTGi-u_IPTG)+((k_out_IPTG*(IPTGi-u_IPTG))^2)^0.5)/2',...
'daTci = (k_in_aTc*(u_aTc-aTci)+((k_in_aTc*(u_aTc-aTci))^2)^0.5)/2-(k_out_aTc*(aTci-u_aTc)+((k_out_aTc*(aTci-u_aTc))^2)^0.5)/2',...
'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP',...
...
'dIPTGi2 = k_iptg2*(u_IPTG-IPTGi2)-0.0165*IPTGi2',...
'daTci2 = k_aTc2*(u_aTc-aTci2)-0.0165*aTci2',...
'dL_RFP2 = 1/0.1386*(kL_p_m02 + (kL_p_m2/(1+(T_GFP2/theta_T2*(1/(1+(aTci2/theta_aTc2)^n_aTc2)))^n_T2)))-0.0165*L_RFP2',...
'dT_GFP2 = 1/0.1386*(kT_p_m02 + (kT_p_m2/(1+(L_RFP2/theta_L2*(1/(1+(IPTGi2/theta_IPTG2)^n_IPTG2)))^n_L2)))-0.0165*T_GFP2');


%==================
% PARAMETER VALUES
% =================

% Mean from PE in AMIGO lsq
parm1 = [3.88000417811186254675e-05 ,4.93255076722256546873e-01 ,2.33237787041401078980e+00 ,4.32576748429144686270e+00 ,7.70000000002619457151e-03 ,3.21876031244284854793e+00 ,2.44899999964425019172e-01 ,1.20000000000233739139e-02 ,2.12958006852205912196e+01 ,];
parm2 = [];

model.par =[parm1, parm2];

end               

