function [inputsPL] = ExtractModelPS(simul_res, simul_dat, j)


    switch simul_dat.model
            case 0
                simul_res.inputsPL.exps.n_obs{j}=2;                         % Number of observables per experiment
                simul_res.inputsPL.exps.obs_names{j} = char('Citrine_AU_M1','Citrine_AU_M2');
                simul_res.inputsPL.exps.obs{j} = char('Citrine_AU_M1 = Cit_AU','Citrine_AU_M2 = Cit_AU_2');% Name of the observables 
                switch simul_dat.iter
                    case 0
                        modelF = 'M3DVSM3D_load_model_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3DVSM3D_load_model_Iter0();
                        simul_res.inputsPL.exps.exp_y0{j}=M3DVSM3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 1
                        modelF = 'M3DVSM3D_load_model_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3DVSM3D_load_model_Iter1();
                        simul_res.inputsPL.exps.exp_y0{j}=M3DVSM3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 2
                        modelF = 'M3DVSM3D_load_model_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3DVSM3D_load_model_Iter2();
                        simul_res.inputsPL.exps.exp_y0{j}=M3DVSM3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 3
                        modelF = 'M3DVSM3D_load_model_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3DVSM3D_load_model_Iter3();
                        simul_res.inputsPL.exps.exp_y0{j}=M3DVSM3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                end
            case 1
                simul_res.inputsPL.exps.n_obs{j}=1;                         % Number of observables per experiment
                simul_res.inputsPL.exps.obs_names{j} = char('Citrine_AU');
                simul_res.inputsPL.exps.obs{j} = char('Citrine_AU = Cit_AU');% Name of the observables 
                switch simul_dat.iter
                    case 0
                        modelF = 'M3D_load_model1_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model1_Iter0();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 1
                        modelF = 'M3D_load_model1_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model1_Iter2();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 2
                        modelF = 'M3D_load_model1_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model1_Iter2();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 3
                        modelF = 'M3D_load_model1_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model1_Iter3();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                end
            case 2
                simul_res.inputsPL.exps.n_obs{j}=1;                         % Number of observables per experiment
                simul_res.inputsPL.exps.obs_names{j} = char('Citrine_AU');
                simul_res.inputsPL.exps.obs{j} = char('Citrine_AU = Cit_AU');% Name of the observables 
                switch simul_dat.iter
                    case 0
                        modelF = 'M3D_load_model2_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model2_Iter0();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 1
                        modelF = 'M3D_load_model2_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model2_Iter1();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 2
                        modelF = 'M3D_load_model2_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model2_Iter2();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                    case 3
                        modelF = 'M3D_load_model2_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsPL.model = M3D_load_model2_Iter3();
                        simul_res.inputsPL.exps.exp_y0{j}=M3D_steady_state(simul_res.inputsPL.model.par, simul_res.expsPL{j}.preIPTG);
                end
    end

    inputsPL = simul_res.inputsPL;


end















