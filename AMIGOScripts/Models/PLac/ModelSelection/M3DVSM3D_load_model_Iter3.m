function [model] = M3DVSM3D_load_model_Iter0()

% As the experimental data are acquired in A.U., M3D is modified by adding
% an algebraic equation for the conversion from molecules number to A.U.
% This means that the parameter vector has an additional entry, represented
% by the scaling factor sc_molec

model.input_model_type='charmodelC';                                                % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             
model.n_st=4*2;                                                                       % Number of states      
model.n_par=9*2;                                                                      % Number of model parameters 
model.n_stimulus=1;                                                                 % Number of inputs, stimuli or control variables   
model.st_names=char('Cit_mrna','Cit_foldedP','Cit_fluo','Cit_AU', ...
                    'Cit_mrna_2','Cit_foldedP_2','Cit_fluo_2','Cit_AU_2');                  % Names of the states                                        
model.par_names=char('alpha1','Vm1','h1','Km1','d1',...
                            'alpha2','d2','Kf','sc_molec', ...
                     'alpha1_2','Vm1_2','h1_2','Km1_2','d1_2',...
                            'alpha2_2','d2_2','Kf_2','sc_molec_2');                         % Names of the parameters                     
model.stimulus_names=char('IPTG');                                                  % Names of the stimuli, inputs or controls                      
model.eqns=...                                                                      % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dCit_mrna=alpha1+Vm1*(IPTG^h1/(Km1^h1+IPTG^h1))-d1*Cit_mrna',...
                    'dCit_foldedP=alpha2*Cit_mrna-(d2+Kf)*Cit_foldedP',...
                    'dCit_fluo=Kf*Cit_foldedP-d2*Cit_fluo',...
                    'dCit_AU = sc_molec*dCit_fluo', ...
                    ...
                    'dCit_mrna_2=alpha1_2+Vm1_2*(IPTG^h1_2/(Km1_2^h1_2+IPTG^h1_2))-d1_2*Cit_mrna_2',...
                    'dCit_foldedP_2=alpha2_2*Cit_mrna_2-(d2_2+Kf_2)*Cit_foldedP_2',...
                    'dCit_fluo_2=Kf_2*Cit_foldedP_2-d2_2*Cit_fluo_2',...
                    'dCit_AU_2 = sc_molec_2*dCit_fluo_2');           
                
%          alpha1	Vm1     h1  Km1     d1     alpha2  d2     Kf   sc_molec            
parm1 = [];
parm2 = [];

model.par =[parm1, parm2];

end