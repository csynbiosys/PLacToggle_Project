function [ res ] = M3DVSM3D_steady_state( theta, IPTG )
%   Computes the steady state of the M3D model structure for the given values of
%   theta and the input IPTG.

% First instance of the model
a1 = theta(1);
Vm1 = theta(2);
h1 = theta(3);
Km1 = theta(4);
d1 = theta(5);
a2 = theta(6);
d2 = theta(7);
Kf = theta(8);
sc_molec = theta(9);

Cit_mrna = (a1 + Vm1*(IPTG^h1/(Km1^h1+IPTG^h1)))/d1;

Cit_foldedP = (a2*Cit_mrna)/(Kf+d2);

Cit_fluo = (Kf*Cit_foldedP)/d2;

Cit_AU = sc_molec*Cit_fluo; 

% Second instance of the model
a1_2 = theta(1);
Vm1_2 = theta(2);
h1_2 = theta(3);
Km1_2 = theta(4);
d1_2 = theta(5);
a2_2 = theta(6);
d2_2 = theta(7);
Kf_2 = theta(8);
sc_molec_2 = theta(9);
                        
Cit_mrna_2 = (a1_2 + Vm1_2*(IPTG^h1_2/(Km1_2^h1_2+IPTG^h1_2)))/d1_2;

Cit_foldedP_2 = (a2_2*Cit_mrna_2)/(Kf_2+d2_2);

Cit_fluo_2 = (Kf_2*Cit_foldedP_2)/d2_2;

Cit_AU_2 = sc_molec_2*Cit_fluo_2; 

res = [Cit_mrna Cit_foldedP Cit_fluo Cit_AU Cit_mrna_2 Cit_foldedP_2 Cit_fluo_2 Cit_AU_2];

end

