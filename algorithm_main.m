%% ====== Final Project ======
%
% Theodoros Papafotiou
% AEM: 9708
%
% ============================

clear;
close all;
clc;

% Centers lim
global c_up
global c_low

% Sigmas lim
global s_up
global s_low

% Constants
global num_params

f = @(x, y) sin(x + y)*sin(y^2);

error_lim = 0.01;
mutate_prob = 0.06;
num_gaussians = 15;
num_population = 50;
num_params = 4;
max_generations = 10000;
genes_len = num_gaussians * num_params;

num_random = 0.1 * num_population;
num_intact = 0.5 * num_population;

genes = zeros(genes_len, 1);
population = zeros(num_population, genes_len + 1);
best_gene = zeros(max_generations, genes_len);
error_gen = inf(max_generations, 1);

c_up = 4;
c_low = -4;
s_up = 1.3;
s_low = 0.2;

%% First Generation

generation = 1;

for i = 1:num_population
    for j = 1:num_params:genes_len
        genes(j) = unifrnd(c_low, c_up);
        genes(j+1) = unifrnd(c_low, c_up);
        genes(j+2) = unifrnd(s_low, s_up);
        genes(j+3) = unifrnd(s_low, s_up);
    end
    population(i, 1) = fitness_function(genes, f);
    population(i, 2:end) = genes;
end

% Sort based on the first column (fitness values)
population = sort_fit(population, 1);

best_gene(generation, :) = population(1, 2:end);
error_gen(generation) = population(1, 1);
last_error = population(1, 1);

%% Main Loop

while last_error >= error_lim && generation <= max_generations
    
    last_population = population;
    population = zeros(num_population, genes_len + 1);
    
    % Keep first K best genes intact
    for i = 1:num_intact
        population(i, 2:end) = last_population(i, 2:end);
    end
    
    % Select T genes randomly
    for i = (num_intact+1) : (num_intact+num_random)
        
        index = round(unifrnd(num_intact+1, num_population));
        population(i, 2:end) = last_population(index, 2:end);
    end
    
    % Crossover the best genes
    for i = (num_intact+num_random+1):num_population
       
        index1 = round(unifrnd(1, num_intact));
        index2 = round(unifrnd(1, num_intact));
        
        first_gene = last_population(index1, 2:end);
        second_gene = last_population(index2, 2:end);
        
        population(i, 2:end) = crossover(first_gene, second_gene);
    end
    
    % Mutate some genes
    for i = 1:num_population
        
        if rand < mutate_prob
            population(i, 2:end) = mutate(population(i, 2:end));
        end
        
        population(i, 1) = fitness_function(population(i, 2:end), f);
    end
    
    % Sort based on the first column (fitness values)
    population = sort_fit(population, 1);

    best_gene(generation, :) = population(1, 2:end);
    error_gen(generation) = population(1, 1);
    last_error = population(1, 1);
    
    generation = generation + 1
end

selected_gene = best_gene(generation-1, :);
selected_gene_error = error_gen(generation-1);

fprintf("Generations demanded: %d\n", generation - 1);