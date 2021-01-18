function [simul_res] = wrapInputDetails(simul_res, k, syst)

    switch syst
        case "PL"
            
            IPTG = simul_res.expsPL{k}.IPTGfull;
            tim = simul_res.expsPL{k}.time;
            inp = IPTG(1);
            evnT = tim(1);
            
            for i = 2:length(IPTG)
                if IPTG(i) ~= IPTG(i-1)
                    inp = [inp, IPTG(i)];
                    evnT = [evnT, tim(i)];
                end
            end
            evnT = [evnT, tim(end)];
            
            simul_res.expsPL{k}.inp = inp;
            simul_res.expsPL{k}.evnT = evnT;
            
            
            
        case "TS"
            IPTG = simul_res.expsTS{k}.IPTGfull;
            aTc = simul_res.expsTS{k}.aTcfull;
            tim = simul_res.expsTS{k}.time;
            
            inp1 = IPTG(1);
            evnT = tim(1);
            inp2 = aTc(1);
            
            for i = 2:length(IPTG)
                if IPTG(i) ~= IPTG(i-1) || aTc(i) ~= aTc(i-1)
                    inp1 = [inp1, IPTG(i)];
                    evnT = [evnT, tim(i)];
                    inp2 = [inp2, aTc(i)];
                end
            end
            evnT = [evnT, tim(end)];
            inp = [inp1; inp2];
            simul_res.expsTS{k}.inp = inp;
            simul_res.expsTS{k}.evnT = evnT;
            
            
        case ""
            
            disp("--------------------------------- WARNING ---------------------------------");
            disp(" ");
            disp("There seems to be a problem with the file you have given. ");
            disp("I cannot identify the system it comes from... :(");
            disp(" ");
            disp("---------------------------------------------------------------------------");
            return
            
    end







end