% This function calculates the fitness function value for a given gene. 

function [error] = fitnessFunction(genes, numofGaussians, errorType)

    f = @(u1,u2) sin(u1 + u2)*sin(u2^2); 
    
    u1Limits = [-1 2];
    u2Limits = [-2 1];
    
    chromosomeSize = length(genes)/numofGaussians;
    
    error = 0;
    points = 20;
    
    for u1=linspace(u1Limits(1),u1Limits(2),points)
        for u2=linspace(u2Limits(1),u2Limits(2),points)
            
            fValue = f(u1,u2);
            fApprox = 0;

            for j=1:chromosomeSize:length(genes)
                gaussianValue = gaussianFunction(u1, u2, genes(j), genes(j+1), genes(j+2), genes(j+3), genes(j+4));
                fApprox = fApprox + gaussianValue;
            end

            if errorType == "Linear"

                error = error + abs(fValue - fApprox);

            elseif errorType == "Mean Square"

                error = error + (fValue - fApprox)^2;

            end
        end
    end
    
    error = error/(points^2);

end