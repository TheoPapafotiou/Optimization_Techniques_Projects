function [min, max] = limits_f(f)

global min_x
global max_x
global min_y
global max_y

interval = 200;

max = -inf;
min = inf;
for i = linspace(min_x, max_x, interval)
    for j = linspace(min_y, max_y, interval)
       value = f(i, j);
       if value > max
           max = value;
       end
       
       if value < min
           min = value;
       end
    end
end

