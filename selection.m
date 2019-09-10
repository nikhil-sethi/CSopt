function mate= selection(fitness,population)
%Selection of fittest individuals by fitness proportional selection
global pop_size 
fit_sum=sum(fitness,1);
csum=0; 
ball=rand(1,1)*fit_sum;
    for i=1:pop_size 
    csum=csum+fitness(i);
    if csum>=ball
        mate=population{i}; 
        break
    end   
    end
end