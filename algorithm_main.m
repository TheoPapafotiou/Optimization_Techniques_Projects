%% ====== Final Project ======
%
% Theodoros Papafotiou
% AEM: 9708
%
% ============================
% ========== TRIALS ==========
%   - Fitness Function change power
%   + Change num of gaussians
%   - Final final with error 0.001 and generations 10000000000000000
%   + Population numbers (10, 50, 100, 200)
%   - Random and Best probabilities
%   + Mutation Probability
%
%



clear;
close all;
clc;

% Centers lim
global c_up
global c_low

% Sigmas lim
global s_up
global s_low

% X-Y limits
global min_x
global max_x
global min_y
global max_y

% F limits
global min_F
global max_F

% Constants
global num_params
f = @(x, y) sin(x + y).*sin(y^2);

error_lim = 0.002;
mutate_prob = 0.1;
num_gaussians = 8;
num_population = 100;
num_params = 5;
max_generations = 10000;
chromosome_len = num_gaussians * num_params;

num_random = 0.1 * num_population;
num_intact = 0.4 * num_population;

if mod((num_population - num_random - num_intact), 2) ~= 0
    num_random = num_random - 1;
end

genes = zeros(chromosome_len, 1);
population = zeros(num_population, chromosome_len + 1);
best_chromosome = zeros(max_generations, chromosome_len);
error_gen = inf(max_generations, 1);

c_up = 5;
c_low = -5;
s_up = 1.2;
s_low = 0.1;

% X-Y limits
min_x = -1;
max_x = 2;
min_y = -2;
max_y = 1;

% F limits
[min_F, max_F] = limits_f(f);

% Plot test function
plot_3D(1, genes)

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
    population(i, 1) = fitness_function(genes, f);
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
        population(i, 1) = fitness_function(population(i, 2:end), f);
    end
    
    % Sort based on the first column (fitness values)
    population = sort_fit(population, 1);

    best_chromosome(generation, :) = population(1, 2:end);
    error_gen(generation) = population(1, 1);
    last_error = population(1, 1);
    
    generation = generation + 1;
    disp(generation);
end

plot_3D(2, best_chromosome(generation-1, :))

if generation > 1
    figure('PaperPosition',[.25 .25 8 6]);
    plot(1:generation-1, error_gen(1:generation-1))
    grid on
    title("Error throughout all generations")
    xlabel("Generations");
    ylabel("Error");
    saveas(gcf, ['error_gaussian_', int2str(num_gaussians), '.pdf']);
end

if generation > 1
    selected_chromosome = best_chromosome(generation-1, :);
    selected_chromosome_error = error_gen(generation-1);
else
    selected_chromosome = best_chromosome(generation, :);
    selected_chromosome_error = error_gen(generation);
end
    
fprintf("Generations demanded: %d\n", generation - 1);