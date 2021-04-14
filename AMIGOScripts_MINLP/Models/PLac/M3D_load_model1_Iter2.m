function [model] = M3D_load_model1_Iter2() 
 
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
model.par = [1.69654844638084736919e-02 ,3.72140323626805880064e-01 ,2.64520591033390184421e+00 ,8.27847347695314006444e+00 ,1.16130015903986555381e-01 ,3.99488554664783557246e-01 ,3.73559683669513059590e-03 ,2.16999999608232900516e-02 ,4.34215123237483169305e+00 ,];
end