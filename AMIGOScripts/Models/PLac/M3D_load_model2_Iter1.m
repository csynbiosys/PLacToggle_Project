function [model] = M3D_load_model2_Iter1() 
 
model.input_model_type='charmodelC'; 
model.n_st=4; 
model.n_par=9; 
model.n_stimulus=1;model.st_names=char('Cit_mrna','Cit_foldedP','Cit_fluo','Cit_AU'); 
model.par_names=char('alpha1','Vm1','h1','Km1','d1','alpha2','d2','Kf','sc_molec'); 
model.stimulus_names=char('IPTG'); 
model.eqns=... 
    char('dCit_mrna=alpha1+Vm1*(IPTG^h1/(Km1^h1+IPTG^h1))-d1*Cit_mrna',... 
         'dCit_foldedP=alpha2*Cit_mrna-(d2+Kf)*Cit_foldedP',... 
         'dCit_fluo=Kf*Cit_foldedP-d2*Cit_fluo',... 
         'dCit_AU = sc_molec*dCit_fluo');
model.par = [7.41047892067991671033e-03 ,2.51030338244406514558e-01 ,4.89999999996938662150e+00 ,3.94214844083089488436e+00 ,7.20248196451816619090e-02 ,7.11697348169151422503e-01 ,2.29208737230976889593e-03 ,2.16999999999605841516e-02 ,8.24644509479568799115e-01];
end