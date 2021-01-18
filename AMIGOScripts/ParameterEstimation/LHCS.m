
function [ParFull] = LHCS(theta_max, theta_min)

    numExperiments = 100; 

    for i = 1:length(theta_min)
        if theta_min(i) == 0
            theta_min(i) = 1e-50;
        end
    end


    M_norm = lhsdesign(numExperiments,length(theta_min));
    M = zeros(size(M_norm));
    for c=1:size(M_norm,2)
        for r=1:size(M_norm,1)
            M(r,c) = 10^(M_norm(r,c)*(log10(theta_max(1,c))-log10(theta_min(1,c)))+log10(theta_min(1,c))); % log exploration
        end
    end 

    % %check the location of the parameters that are fixed
    ParFull = M;  


end




































