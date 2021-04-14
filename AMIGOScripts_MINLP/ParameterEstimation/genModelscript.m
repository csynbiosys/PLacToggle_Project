function [] = genModelscript(fit_res, fit_dat)

    switch fit_res.system
        case "PL"
            fid = fopen( strcat(['.\Models\PLac\M3D_load_model',num2str(fit_dat.model),'_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
            fprintf( fid, strcat(['function [model] = M3D_load_model',num2str(fit_dat.model),'_Iter',num2str(fit_dat.iter),'() \n \n']));
            fprintf( fid, 'model.input_model_type=''charmodelC''; \n');
            fprintf( fid, 'model.n_st=4; \n');
            fprintf( fid, 'model.n_par=9; \n');
            fprintf( fid, 'model.n_stimulus=1;\');
            fprintf( fid, 'model.st_names=char(''Cit_mrna'',''Cit_foldedP'',''Cit_fluo'',''Cit_AU''); \n');
            fprintf( fid, 'model.par_names=char(''alpha1'',''Vm1'',''h1'',''Km1'',''d1'',''alpha2'',''d2'',''Kf'',''sc_molec''); \n');
            fprintf( fid, 'model.stimulus_names=char(''IPTG''); \n');
            fprintf( fid, '');
            fprintf( fid, 'model.eqns=... \n');
            fprintf( fid, '    char(''dCit_mrna=alpha1+Vm1*(IPTG^h1/(Km1^h1+IPTG^h1))-d1*Cit_mrna'',... \n');
            fprintf( fid, '         ''dCit_foldedP=alpha2*Cit_mrna-(d2+Kf)*Cit_foldedP'',... \n');
            fprintf( fid, '         ''dCit_fluo=Kf*Cit_foldedP-d2*Cit_fluo'',... \n');
            fprintf( fid, '         ''dCit_AU = sc_molec*dCit_fluo'');\n');
            fprintf( fid, '');
            fprintf( fid, strcat(['model.par = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),']; ']));
            fprintf( fid, '\n');
            fprintf( fid, 'end');
            fclose(fid);        
            
            % Add the parameter vector in the model selection file
            fid = fopen( strcat(['.\Models\PLac\ModelSelection\M3DVSM3D_load_model','_Iter',num2str(fit_dat.iter),'.m']) );
            c = textscan(fid,'%s','delimiter','\n');
            fclose(fid); 
            
            lines = c{1};
            relevant =  find(~cellfun(@isempty,strfind(c{1},strcat(['parm',num2str(fit_dat.model),' = [']))));
            lines{relevant} = strcat(['parm',num2str(fit_dat.model),' = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),'];']);
            
            fid = fopen(strcat(['.\Models\PLac\ModelSelection\M3DVSM3D_load_model','_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
            for i = 1:length(lines)
                fprintf(fid,'%s\n',lines{i});
            end
            fclose(fid)
            
            
        case "TS"
            switch fit_dat.model
                case 1
                    fid = fopen( strcat(['.\Models\ToggleSwitch\Model1\ToggleSwitch_load_model_M1_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
                    fprintf( fid, strcat(['function [model] = ToggleSwitch_load_model_M1_Iter',num2str(fit_dat.iter),'() \n \n']));   
                    fprintf( fid, ' \n');
                    fprintf( fid, 'model.input_model_type=''charmodelC''; \n');
                    fprintf( fid, 'model.n_st=4; \n');
                    fprintf( fid, 'model.n_par=16; \n');
                    fprintf( fid, 'model.n_stimulus=2;  \n');
                    fprintf( fid, 'model.stimulus_names=char(''u_IPTG'',''u_aTc''); \n');
                    fprintf( fid, 'model.st_names=char(''IPTGi'',''aTci'',''L_RFP'',''T_GFP''); \n');
                    fprintf( fid, 'model.par_names=char(''k_in_IPTG'',''k_out_IPTG'',... \n');
                    fprintf( fid, '               ''k_in_aTc'',''k_out_aTc'',... \n');
                    fprintf( fid, '               ''kL_p_m0'',''kL_p_m'',''theta_T'',''theta_aTc'',''n_aTc'',''n_T'',... \n');
                    fprintf( fid, '               ''kT_p_m0'',''kT_p_m'',''theta_L'',''theta_IPTG'',''n_IPTG'',''n_L''); \n');
                    fprintf( fid, ' \n');
                    fprintf( fid, 'model.eqns=...           \n');
                    fprintf( fid, '               char(''dIPTGi = (k_in_IPTG*(u_IPTG-IPTGi)+((k_in_IPTG*(u_IPTG-IPTGi))^2)^0.5)/2-(k_out_IPTG*(IPTGi-u_IPTG)+((k_out_IPTG*(IPTGi-u_IPTG))^2)^0.5)/2'',... \n');
                    fprintf( fid, '                    ''daTci = (k_in_aTc*(u_aTc-aTci)+((k_in_aTc*(u_aTc-aTci))^2)^0.5)/2-(k_out_aTc*(aTci-u_aTc)+((k_out_aTc*(aTci-u_aTc))^2)^0.5)/2'',... \n');
                    fprintf( fid, '                    ''dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP'',... \n');
                    fprintf( fid, '                    ''dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP''); \n');
                    fprintf( fid, ' \n');
                    fprintf( fid, strcat(['model.par = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),']; ']));
                    fprintf( fid, ' \n');
                    fprintf( fid, 'end \n');
                    fclose(fid);  
                    
                    % Add the parameter vector in the model selection file
                    fid = fopen( strcat(['.\Models\ToggleSwitch\Model1vsModel2\ToggleSwitch_load_model_M1vsM2_ModelSelection','_Iter',num2str(fit_dat.iter),'.m']));
                    c = textscan(fid,'%s','delimiter','\n');
                    fclose(fid); 

                    lines = c{1};
                    relevant =  find(~cellfun(@isempty,strfind(c{1},strcat(['parm',num2str(fit_dat.model),' = [']))));
                    lines{relevant} = strcat(['parm',num2str(fit_dat.model),' = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),'];']);

                    fid = fopen(strcat(['.\Models\ToggleSwitch\Model1vsModel2\ToggleSwitch_load_model_M1vsM2_ModelSelection','_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
                    for i = 1:length(lines)
                        fprintf(fid,'%s\n',lines{i});
                    end
                    fclose(fid)
                    
                case 2
                    fid = fopen( strcat(['.\Models\ToggleSwitch\Model2\ToggleSwitch_load_model_M2_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
                    fprintf( fid, strcat(['function [model] = ToggleSwitch_load_model_M2_Iter',num2str(fit_dat.iter),'() \n \n']));   
                    fprintf( fid, ' \n');
                    fprintf( fid, 'model.input_model_type=''charmodelC''; \n');
                    fprintf( fid, 'model.n_st=4; \n');
                    fprintf( fid, 'model.n_par=14; \n');
                    fprintf( fid, 'model.n_stimulus=2;  \n');
                    fprintf( fid, 'model.stimulus_names=char(''u_IPTG'',''u_aTc''); \n');
                    fprintf( fid, 'model.st_names=char(''IPTGi'',''aTci'',''L_RFP'',''T_GFP''); \n');
                    fprintf( fid, 'model.par_names=char(''k_iptg'',... \n');
                    fprintf( fid, '               ''k_aTc'',... \n');
                    fprintf( fid, '               ''kL_p_m0'',''kL_p_m'',''theta_T'',''theta_aTc'',''n_aTc'',''n_T'',... \n');
                    fprintf( fid, '               ''kT_p_m0'',''kT_p_m'',''theta_L'',''theta_IPTG'',''n_IPTG'',''n_L''); \n');
                    fprintf( fid, ' \n');
                    fprintf( fid, 'model.eqns=...           \n');
                    fprintf( fid, '               char(''dIPTGi = k_iptg*(u_IPTG-IPTGi)-0.0165*IPTGi'',... \n');
                    fprintf( fid, '                    ''daTci = k_aTc*(u_aTc-aTci)-0.0165*aTci'',... \n');
                    fprintf( fid, '                    ''dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP'',... \n');
                    fprintf( fid, '                    ''dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP''); \n');
                    fprintf( fid, ' \n');
                    fprintf( fid, strcat(['model.par = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),']; ']));
                    fprintf( fid, ' \n');
                    fprintf( fid, 'end \n');
                    fclose(fid);  
                    
                    % Add the parameter vector in the model selection file
                    fid = fopen( strcat(['.\Models\ToggleSwitch\Model1vsModel2\ToggleSwitch_load_model_M1vsM2_ModelSelection','_Iter',num2str(fit_dat.iter),'.m']));
                    c = textscan(fid,'%s','delimiter','\n');
                    fclose(fid); 

                    lines = c{1};
                    relevant =  find(~cellfun(@isempty,strfind(c{1},strcat(['parm2 = [']))));
                    lines{relevant} = strcat(['parm2 = [',num2str(fit_res.bestRun.fit.thetabest', '%10.20e ,'),'];']);

                    fid = fopen(strcat(['.\Models\ToggleSwitch\Model1vsModel2\ToggleSwitch_load_model_M1vsM2_ModelSelection','_Iter',num2str(fit_dat.iter),'.m']), 'wt' );
                    for i = 1:length(lines)
                        fprintf(fid,'%s\n',lines{i});
                    end
                    fclose(fid)
            end
    end










end





















