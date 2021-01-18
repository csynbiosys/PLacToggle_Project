function [ res ] = M1vsM2SF_compute_steady_state_Analytical_ModelSelection(theta, InitialStates_AU, initial_u)
% Computes the steady state of the ToggleSwitch models 1 and 2 for the given values of
% theta and the inputs u_IPTG and u_aTc. Both models are included in the
% same model file for OED purposses. 

% Model 1
k_in_iptg = theta(1);
k_out_iptg = theta(2);
k_in_aTc = theta(3);
k_out_aTc = theta(4);

kL_p_m0 = theta(5);
kL_p_m = theta(6);
theta_T = theta(7);
theta_aTc = theta(8);
n_aTc = theta(9);
n_T = theta(10);
kT_p_m0 = theta(11);
kT_p_m = theta(12);
theta_L = theta(13);
theta_IPTG = theta(14);
n_IPTG = theta(15);
n_L = theta(16);

sc_molec_1a = theta(17);
sc_molec_2a = theta(18);

% Model 2
k_iptg = theta(19);
k_aTc = theta(20);

kL_p_m02 = theta(21);
kL_p_m2 = theta(22);
theta_T2 = theta(23);
theta_aTc2 = theta(24);
n_aTc2 = theta(25);
n_T2 = theta(26);
kT_p_m02 = theta(27);
kT_p_m2 = theta(28);
theta_L2 = theta(29);
theta_IPTG2 = theta(30);
n_IPTG2 = theta(31);
n_L2 = theta(32);

sc_molec_1b = theta(33);
sc_molec_2b = theta(34);


preRFP = InitialStates_AU(1);
preGFP = InitialStates_AU(2);
preRFP2 = InitialStates_AU(3);
preGFP2 = InitialStates_AU(4);

u_IPTG = initial_u(1);
u_aTc = initial_u(2);

%% Steady state equation
% Model 1
aTci = u_aTc;
IPTGi = u_IPTG;

L_RFP = (1/(0.0165*0.1386))*(kL_p_m0 + (kL_p_m/(1+(preGFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)));
T_GFP = (1/(0.0165*0.1386))*(kT_p_m0 + (kT_p_m/(1+(preRFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)));

L_RFP_AU= sc_molec_1a*L_RFP; 
T_GFP_AU= sc_molec_2a*T_GFP; 

% Model 2
aTci2 = k_aTc*u_aTc/(0.0165+k_aTc);
IPTGi2 = k_iptg*u_IPTG/(0.0165+k_iptg);

L_RFP2 = (1/(0.0165*0.1386))*(kL_p_m02 + (kL_p_m2/(1+(preGFP2/theta_T2*(1/(1+(aTci2/theta_aTc2)^n_aTc2)))^n_T2)));
T_GFP2 = (1/(0.0165*0.1386))*(kT_p_m02 + (kT_p_m2/(1+(preRFP2/theta_L2*(1/(1+(IPTGi2/theta_IPTG2)^n_IPTG2)))^n_L2)));

L_RFP_AU2= sc_molec_1b*L_RFP; 
T_GFP_AU2= sc_molec_2b*T_GFP; 

res = [IPTGi aTci L_RFP T_GFP L_RFP_AU T_GFP_AU...
       IPTGi2 aTci2 L_RFP2 T_GFP2 L_RFP_AU2 T_GFP_AU2];

end
