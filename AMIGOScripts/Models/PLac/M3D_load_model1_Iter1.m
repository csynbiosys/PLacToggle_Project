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
model.par = [7.37733443872067278652e-03 ,1.37737933166126536033e-01 ,3.19582276253846364611e+00 ,5.59381040451654509837e+00 ,2.29999999999974724663e-01 ,4.19468393695156760437e-01 ,1.73369990666837081074e-03 ,2.16999999999767899383e-02 ,8.30773066710787588818e+00 ,];
end