%little gentetic algorithm #1
clear cla
global G pop_size chrom_len crossover_prob mut_prob genome_len unknowns ul ll x y n;
unknowns=11;
G=50; % Maximum number of generations

pop_size=50; %population size
genome_len=5; %length of genome(unknown)
chrom_len=unknowns*genome_len ; %Chromosome=[x1 y1 x2 y2....xn yn] 
crossover_prob=0.6; %probability that crossovrer should take place
mut_prob=0.00; %probability that mutation should take place`
pop_temp=cell(pop_size,1); %preallocation for speed
elitism_prob=0.00;
fitness=zeros(pop_size,G);
avgfit=zeros(G,1);
maxfit=zeros(G,1);
n=5;    %no of coordinates
%h = axes('Position',[0 0 1 1],'Visible','off');

for g0=1
    pop=cell(pop_size,G);
    for i=1:pop_size
    %Variable Consraints
     %  x                    y                      t
    ul_x=10;             ul_y=pi/2;      ul_t=1.5;
    ll_x=7;               ll_y=0;         ll_t=0.5;
    
    ul=[ul_x ul_y ul_t];
    ll=[ll_x ll_y ll_t];
    
        %INITIALISATION   

        pop{i,g0}= rand(1,chrom_len)<0.5; %random pop of 0,1's with equal probability of 0 and 1 appearing
        realpop(i,:)=bin2real(pop{i,g0});
        cdo_pol=sortrows(fullarray(realpop(i,1:2:end-1),realpop(i,2:2:end-1)),2);
        cdo_pol=[cdo_pol(end,:);cdo_pol]; % outer boundary polar array; adding the last element at top to complete the loop
        t=realpop(i,end); %thickness as the 11th unknown
        cdi_pol=scale_in(cdo_pol,t); % Inner boundary as a function of thickness
        cdi_pol=[cdi_pol(end,:);cdi_pol]; %adding the last element at top to complete the loop
        cdi_pol(cdi_pol>ul_x)=ll_x;
        
        subplot(2,2,1);
        title('Current CS');
        cla
        polarplot(cdo_pol(:,2),cdo_pol(:,1)); hold on
        polarplot(cdi_pol(:,2),cdi_pol(:,1));
        pause(0.03)
        
        fitness(i,g0)=fitfunc(cdo_pol,cdi_pol); 
        fitness(fitness<=0)=0; fitness(fitness>100)=0; fitness(isnan(fitness))=0; % ensuring non inclusion of non sensical geometries
    end  
       avgfit(g0)=mean(fitness(:,g0));
       maxfit(g0)=max(fitness(:,g0));
       g0
 end
               g=g0;
  %%   
for g0=2:G
  
   for i=1:pop_size
        %REPRODUCTION
        %Selection of fittest individuals by fitness proportional selection
        parent1=selection(fitness(:,g),pop(:,g));
        parent2=selection(fitness(:,g),pop(:,g));
        %Crossover
        if rand<crossover_prob
            offspring=crossover(parent1,parent2);
            pop_temp{i,:}=offspring; %temporary population made with new children
        %no crossover    
        else
            pop_temp{i,:}=selection(fitness(:,g),pop(:,g)); %pop_temp populated in case there is no crossover
        end
    end
%             
% %         %Elitism
        
          if rand<elitism_prob
              'elitism'
             winners=pop_temp(fitness(:,g)>=1.95); %selection of fittest individuals as winners
             pop_temp(fitness(:,g)==min(fitness(:,g)))=winners(randi(numel(winners))); % replacing the losers with minimum fitness with the winners
          end
        
        
        %Mutation
    if rand<mut_prob
        'mutation'
        for i=1:pop_size
            temp=pop_temp{i,:};
            for k=1:chrom_len
                 if temp(k)==0
                    temp(k)=1;
                 elseif temp(k)==1
                    temp(k)=0;
                 end
            end
            
            pop_temp{i,:}=temp;
        end
    end
       
    %Replace and calculate fitness of new population at index g0
        pop(:,g0)=pop_temp;    
        for i=1:pop_size
            realpop(i,:)=bin2real(pop{i,g0});
            cdo_pol=sortrows(fullarray(realpop(i,1:2:end-1),realpop(i,2:2:end-1)),2);
            cdo_pol=[cdo_pol(end,:);cdo_pol];
            t=realpop(i,end); %thickness as the 11th unknown
            cdi_pol=scale_in(cdo_pol,t);
            cdi_pol=[cdi_pol(end,:);cdi_pol];
            cdi_pol(cdi_pol>ul_x)=ll_x;
            
            subplot(2,2,1);
            title('Current CS');
            cla
            polarplot(cdo_pol(:,2),cdo_pol(:,1)); hold on
            polarplot(cdi_pol(:,2),cdi_pol(:,1));
            
            pause(0.03);
            
            fitness(i,g0)=fitfunc(cdo_pol,cdi_pol);
            fitness(fitness<=0)=0; fitness(fitness>100)=0; fitness(isnan(fitness))=0;
            %Current plot
            
            %plot Alltime best
           if fitness(i,g0)>=max(reshape(fitness,[1,G*pop_size]))
               max(reshape(fitness,[1,G*pop_size])) 
               'best'
                % set(gcf,'CurrentAxes',h)
                % text(.025,.6,fitness(i,g0),'FontSize',12)
               
               subplot(2,2,2);
               title('Best CS yet');
               cla
               polarplot(cdo_pol(:,2),cdo_pol(:,1)); hold on
               polarplot(cdi_pol(:,2),cdi_pol(:,1)); 
               
           end
       avgfit(g0)=mean(fitness(:,g0));
    
       maxfit(g0)=max(fitness(:,g0));
        end
        subplot(2,2,[3,4]);
        title('Average fitness Vs. Generations');
        plot(g0,avgfit(g0),'.b'); hold on;
        
 %      pause(0.1);
%        set(gcf,'CurrentAxes',h)
%        str(1)={'Current Generation=%d',g};
%        str(2)=Average fitness=avgfit(g);
%        
%        text(.025,.2,'Current Gen,'FontSize',12)

       
        g=g0; %change index 
        
end  
    
%%


