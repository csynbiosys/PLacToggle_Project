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
model.par = [6.77315733675462258723e-03 ,2.11398071716381141805e-01 ,4.89999999937088492885e+00 ,5.84362742433135373687e+00 ,2.29999999999975029974e-01 ,3.58125204079745573793e-01 ,1.91114978425849474201e-03 ,2.16999999999765644243e-02 ,5.49368601342863360770e+00 ,];
end