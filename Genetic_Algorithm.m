function [error_gen, generation, total_duration, selected_chromosome] = ...
                Genetic_Algorithm(f, error_lim, mutate_prob, num_gaussians, ...
                                    num_population, max_generations, num_random, ...
                                        num_intact, error_type)

    global c_up
    global c_low
    global s_up
    global s_low
    global min_F
    global max_F
    global num_params

    chromosome_len = num_gaussians * num_params;
    genes = zeros(chromosome_len, 1);
    population = zeros(num_population, chromosome_len + 1);
    best_chromosome = zeros(max_generations, chromosome_len);
    error_gen = inf(max_generations, 1);

    % Start timer
    start_time = tic;

    %% First Generation

    generation = 1;

    for i = 1:num_population
        for j = 1:num_params:chromosome_len
            genes(j) = unifrnd(c_low, c_up);
            genes(j+1) = unifrnd(c_low, c_up);
            genes(j+2) = unifrnd(s_low, s_up);
            genes(j+3) = unifrnd(s_low, s_up);
            genes(j+4) = unifrnd(min_F, max_F);
        end
        population(i, 1) = fitness_function(genes, f, error_type);
        population(i, 2:end) = genes;
    end

    % Sort based on the first column (fitness values)
    population = sort_fit(population, 1);

    best_chromosome(generation, :) = population(1, 2:end);
    error_gen(generation) = population(1, 1);
    last_error = population(1, 1);

    %% Main Loop

    while last_error >= error_lim && generation <= max_generations

        last_population = population;
        population = zeros(num_population, chromosome_len + 1);

        % Keep first K best genes intact
        for i = 1:num_intact
            population(i, 2:end) = last_population(i, 2:end);
        end

        % Select T chromosomes randomly
        for i = (num_intact+1) : (num_intact+num_random)

            index = round(unifrnd(num_intact+1, num_population));
            population(i, 2:end) = last_population(index, 2:end);
        end

        % Crossover the best chromosomes
        for i = (num_intact+num_random+1):2:num_population

            index1 = round(unifrnd(1, num_intact));
            index2 = round(unifrnd(1, num_intact));
            while index2 == index1
                index2 = round(unifrnd(1, num_intact));
            end

            first_chromosome = last_population(index1, 2:end);
            second_chromosome = last_population(index2, 2:end);

            [population(i, 2:end), population(i+1, 2:end)] = crossover(first_chromosome, second_chromosome);
        end

        % Mutate some chromosomes
        for i = 1:num_population

            if rand < mutate_prob
                population(i, 2:end) = mutate(population(i, 2:end));
            end
        end

        for i = 1:num_population
            population(i, 1) = fitness_function(population(i, 2:end), f, error_type);
        end

        % Sort based on the first column (fitness values)
        population = sort_fit(population, 1);

        best_chromosome(generation, :) = population(1, 2:end);
        error_gen(generation) = population(1, 1);
        last_error = population(1, 1);

        generation = generation + 1;
        disp(generation);
    end

    total_duration = toc(start_time); 

    if generation > 1
        selected_chromosome = best_chromosome(generation-1, :);
        selected_chromosome_error = error_gen(generation-1);
    else
        selected_chromosome = best_chromosome(generation, :);
        selected_chromosome_error = error_gen(generation);
    end

    fprintf("Generations demanded: %d\n", generation - 1);
    fprintf("Selected Chromosome Error: %f\n", selected_chromosome_error);
    

end