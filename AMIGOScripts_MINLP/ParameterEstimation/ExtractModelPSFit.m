function [inputs] = ExtractModelPSFit(fit_res, fit_dat, j)


    switch fit_dat.model
            case 1
                fit_res.inputs.exps.n_obs{j}=1;                         % Number of observables per experiment
                fit_res.inputs.exps.obs_names{j} = char('Citrine_AU');
                fit_res.inputs.exps.obs{j} = char('Citrine_AU = Cit_AU');% Name of the observables 
                switch fit_dat.iter
                    case 1
                        modelF = 'M3D_load_model1_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model1_Iter0();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                    case 2
                        modelF = 'M3D_load_model1_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model1_Iter2();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                    case 3
                        modelF = 'M3D_load_model1_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model1_Iter2();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                end
            case 2
                fit_res.inputs.exps.n_obs{j}=1;                         % Number of observables per experiment
                fit_res.inputs.exps.obs_names{j} = char('Citrine_AU');
                fit_res.inputs.exps.obs{j} = char('Citrine_AU = Cit_AU');% Name of the observables 
                switch fit_dat.iter
                    case 1
                        modelF = 'M3D_load_model2_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model2_Iter0();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                    case 2
                        modelF = 'M3D_load_model2_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model2_Iter1();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                    case 3
                        modelF = 'M3D_load_model2_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = M3D_load_model2_Iter2();
                        fit_res.inputs.exps.exp_y0{j}=M3D_steady_state(fit_res.inputs.model.par, fit_res.exps{j}.preIPTG);
                end
    end

    inputs = fit_res.inputs;


end















