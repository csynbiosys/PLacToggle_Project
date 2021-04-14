function [model] = M3D_load_model2_Iter2() 
 
model.input_model_type='charmodelC'; 
model.n_st=4; 
model.n_par=9; 
model.n_stimulus=1;
model.st_names=char('Cit_mrna','Cit_foldedP','Cit_fluo','Cit_AU'); 
model.par_names=char('alpha1','Vm1','h1','Km1','d1','alpha2','d2','Kf','sc_molec'); 
model.stimulus_names=char('IPTG'); 
model.eqns=... 
    char('dCit_mrna=alpha1+Vm1*(IPTG^h1/(Km1^h1+IPTG^h1))-d1*Cit_mrna',... 
         'dCit_foldedP=alpha2*Cit_mrna-(d2+Kf)*Cit_foldedP',... 
         'dCit_fluo=Kf*Cit_foldedP-d2*Cit_fluo',... 
         'dCit_AU = sc_molec*dCit_fluo');
model.par = [1.68902907054030056166e-02 ,4.71889790068122594313e-01 ,9.56253020512709439593e-01 ,9.99999999999995914379e+00 ,2.29999999999973642195e-01 ,4.35764139315231668892e-01 ,3.27890579882526194203e-03 ,2.16999999999593941313e-02 ,4.51306813049474797594e+00 ,];
end