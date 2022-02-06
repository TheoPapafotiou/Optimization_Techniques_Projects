function [res] = f_analytic(u1, u2, genes)

    global num_params

    res = 0;
    for i = 1:num_params:length(genes)
       c1 = genes(i);
       c2 = genes(i+1);
       s1 = genes(i+2);
       s2 = genes(i+3);
       A = genes(i+4);
       
       res = res + A * exp(-(((u1 - c1)^2) / (2 * s1^2)) - (((u2 - c2)^2) / (2 * s2^2)));
    end
end

