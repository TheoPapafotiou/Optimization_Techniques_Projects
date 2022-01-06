function [gene] = mutate(gene)

    global num_params

    mut_param = unifrnd(1, num_params);
    
    switch(mut_param)
        case 1
            gene(1) = unifrnd(c_low, c_up);
        case 2
            gene(2) = unifrnd(c_low, c_up);
        case 3
            gene(3) = unifrnd(s_low, s_up);
        case 4
            gene(4) = unifrnd(s_low, s_up);
    end
end

