function [res] = f_analytic(u1, u2, genes, genes_len)

    global num_params

    res = 0;
    for i = 1:num_params:genes_len
       c1 = genes(i);
       c2 = genes(i+1);
       s1 = genes(i+2);
       s2 = genes(i+3);
       
       res = res + exp(-(((u1 - c1)^2) / (2 * s1^2)) - (((u2 - c2)^2) / (2 * s2^2)));
    end

end

