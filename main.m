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
%   + Random and Best probabilities
%   + Mutation Probability

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

error_lim = 0.001;
mutate_prob = 0.1;
num_gaussians = 15;
num_population = 100;
num_params = 5;
max_generations = 10000;

num_random = 0.1 * num_population;
num_intact = 0.4 * num_population;

if mod((num_population - num_random - num_intact), 2) ~= 0
    num_random = num_random - 1;
end

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
plot_3D(1)

repetitions = 1;
data_genetic = zeros(repetitions, (num_params*num_gaussians) + 3);
durations = zeros(repetitions, 1);
total_generations = zeros(repetitions, 1);


fig = figure('PaperPosition',[.25 .25 8 6]);
hold on
for i = 1:repetitions
    
    [fit_gen, generation, duration, best_chromosome] = ...
        Genetic_Algorithm(f, error_lim, mutate_prob, num_gaussians, ...
                            num_population, max_generations, num_random, num_intact);
    
    data_genetic(i, 1) = generation;
    data_genetic(i, 2) = duration;
    data_genetic(i, 3) = fit_gen(generation-1);
    data_genetic(i, 4:end) = best_chromosome;
    if generation > 1
        figure(fig);
        plot(1:generation-1, fit_gen(1:generation-1));
    end
end
hold off
grid on
title("Fitness throughout all generations [x" + int2str(repetitions) + "]")
xlabel("Generations");
ylabel("Fitness");
annotation('textbox', [0.5, 0.75, 0.1, 0.1], 'BackgroundColor','#D95319', ...
                    'FaceAlpha', 0.2, 'String', "average generations = " + mean(data_genetic(:, 1)), ...
                        'FitBoxToText','on');
annotation('textbox', [0.5, 0.7, 0.1, 0.1], 'BackgroundColor','#32977D', ...
                    'FaceAlpha', 0.2, 'String', "average duration = " + round(mean(data_genetic(:, 2)), 2) ...
                        + " sec", 'FitBoxToText','on');
annotation('textbox', [0.5, 0.65, 0.1, 0.1], 'BackgroundColor','#93ACAA', ...
                    'FaceAlpha', 0.2, 'String', "average final fitness = " + round(mean(data_genetic(:, 3)), 6) ...
                      , 'FitBoxToText','on');
saveas(gcf, ['plots/error_final_vol3.pdf']);

final_chromosome = data_genetic(repetitions, 4:end);
str = "_final_vol3";
plot_3D(2, final_chromosome, str)
plot_3D(3, final_chromosome, str)
