function offspring=crossover(parent1,parent2)
 global chrom_len
   j=1+rand*(6-1);
   offspring=horzcat(parent1(1:ceil(chrom_len/j)),parent2(ceil(chrom_len/j+1):end));
end