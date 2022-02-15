function [output_chromosome1, output_chromosome2] = crossover(first_chromosome, second_chromosome)

    length_chrom = length(first_chromosome);

    split = round(unifrnd(1, length_chrom));
    
    output_chromosome1(1:split) = first_chromosome(1:split);
    output_chromosome1(split+1:length_chrom) = second_chromosome(split+1:end);
    
    output_chromosome2(1:split) = second_chromosome(1:split);
    output_chromosome2(split+1:length_chrom) = second_chromosome(split+1:end);

end

