function [chromosome] = mutate(chromosome)

    global c_up
    global c_low
    global s_up
    global s_low
    global min_F
    global max_F
    global num_params

    mut_num = round(unifrnd(1, num_params));
    
    for i = 1:mut_num
        mut_param = round(unifrnd(1, length(chromosome)));
        switch(mod(mut_param, 5))
            case 1
                chromosome(mut_param) = unifrnd(c_low, c_up);
            case 2
                chromosome(mut_param) = unifrnd(c_low, c_up);
            case 3
                chromosome(mut_param) = unifrnd(s_low, s_up);
            case 4
                chromosome(mut_param) = unifrnd(s_low, s_up);
            case 0
                chromosome(mut_param) = unifrnd(min_F, max_F);
        end
    end
end

