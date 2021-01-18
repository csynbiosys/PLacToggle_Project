function [model] = M3D_load_model1_Iter1() 
 
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
model.par = [3.88000417811186254675e-05 ,4.93255076722256546873e-01 ,2.33237787041401078980e+00 ,4.32576748429144686270e+00 ,7.70000000002619457151e-03 ,3.21876031244284854793e+00 ,2.44899999964425019172e-01 ,1.20000000000233739139e-02 ,2.12958006852205912196e+01 ,];
end