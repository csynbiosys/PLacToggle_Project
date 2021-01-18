function [inputsTS] = ExtractModelTS(simul_res, simul_dat)

        switch simul_dat.model
            case 0
                switch simul_dat.iter
                    case 0
                        modelF = 'ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter0.m';
%                         modelF = 'ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter0();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter0();
                    case 1
                         modelF = 'ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter1.m';
%                         modelF = 'ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter1();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter1();
                    case 2
                         modelF = 'ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter2.m';
%                         modelF = 'ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter2();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter2();
                    case 3
                         modelF = 'ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter3.m';
%                         modelF = 'ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2_ModelSelection_Iter3();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1vsM2SF_ModelSelection_Iter3();
                end
            case 1
                switch simul_dat.iter
                    case 0
                        modelF = 'ToggleSwitch_load_model_M1_Iter0.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1_Iter0();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1SF_Iter0();
                    case 1
                        modelF = 'ToggleSwitch_load_model_M1_Iter1.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1_Iter1();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1SF_Iter1();
                    case 2
                        modelF = 'ToggleSwitch_load_model_M1_Iter2.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1_Iter2();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1SF_Iter2();
                    case 3
                        modelF = 'ToggleSwitch_load_model_M1_Iter3.m';
%                         modelF = 'ToggleSwitch_load_model_M1SF_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M1_Iter3();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M1SF_Iter3();
                end
            case 2
                switch simul_dat.iter
                    case 0
                        modelF = 'ToggleSwitch_load_model_M2_Iter0.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter0.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M2_Iter0();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M2SF_Iter0();
                    case 1
                        modelF = 'ToggleSwitch_load_model_M2_Iter1.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter1.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M2_Iter1();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M2SF_Iter1();
                    case 2
                        modelF = 'ToggleSwitch_load_model_M2_Iter2.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter2.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M2_Iter2();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M2SF_Iter2();
                    case 3
                        modelF = 'ToggleSwitch_load_model_M2_Iter3.m';
%                         modelF = 'ToggleSwitch_load_model_M2SF_Iter3.m';
                        if exist(modelF, 'file') == 0
                            disp("--------------------------------- WARNING ---------------------------------");
                            disp(" ");
                            disp("It seems the model iteration you have introduced does not exist yet. Sorry :(");
                            disp(" ");
                            disp("---------------------------------------------------------------------------");
                            return
                        end
                        simul_res.inputsTS.model = ToggleSwitch_load_model_M2_Iter3();
%                         simul_res.inputsTS.model = ToggleSwitch_load_model_M2SF_Iter3();
                end
        end
        
    inputsTS = simul_res.inputsTS;

end