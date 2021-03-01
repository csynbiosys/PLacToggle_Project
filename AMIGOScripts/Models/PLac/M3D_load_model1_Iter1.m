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
model.par = [1.58532531045388544455e-02 ,2.87880676913641775361e-01 ,2.88904695319053095304e+00 ,7.63437935164197245541e+00 ,6.73616241293986256489e-02 ,3.52874350255604540827e-01 ,3.40750817911390216017e-03 ,2.16999999999768072856e-02 ,3.05952140200190303432e+00];
end