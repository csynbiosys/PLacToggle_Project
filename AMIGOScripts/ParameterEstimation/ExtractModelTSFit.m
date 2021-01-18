function [inputs] = ExtractModelTSFit(fit_res, fit_dat)

        switch fit_dat.model
            case 1
                switch fit_dat.iter
                    case 1
                        modelF = 'ToggleSwitch_load_model_M1_Iter0.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M1_Iter0();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M1SF_Iter0();
                    case 2
                        modelF = 'ToggleSwitch_load_model_M1_Iter1.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M1_Iter1();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M1SF_Iter1();
                    case 3
                        modelF = 'ToggleSwitch_load_model_M1_Iter2.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M1_Iter2();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M1SF_Iter2();
                end
            case 2
                switch fit_dat.iter
                    case 1
                        modelF = 'ToggleSwitch_load_model_M2_Iter0.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M2_Iter0();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M2SF_Iter0();
                    case 2
                        modelF = 'ToggleSwitch_load_model_M2_Iter1.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M2_Iter1();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M2SF_Iter1();
                    case 3
                        modelF = 'ToggleSwitch_load_model_M2_Iter2.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems you are trying to jump a model iteration. We need to stop :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        fit_res.inputs.model = ToggleSwitch_load_model_M2_Iter2();
%                         fit_res.inputs.model = ToggleSwitch_load_model_M2SF_Iter2();
                end
        end
        
    inputs = fit_res.inputs;

end