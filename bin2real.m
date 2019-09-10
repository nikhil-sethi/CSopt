%binary to real conversion 


%decimal to real conversion    
function realval=bin2real(genome)
 global unknowns ul ll genome_len 
                                                          
        genomes=reshape(genome,1,genome_len,unknowns); %multidimensional array containing each binary string( x or y variable in this case) as a differnt page
        %The following loop goes over each page/variable in the above
        %multi-dim array and converts it to its real value corresponding to
        %its range.
        
        for k=1:unknowns
         if rem(k,2)~=0 && k~=11  
         decimalval(k)=bin2dec(genomes(:,:,k));
         realval(k)= ((ul(1)-ll(1))/(2.^genome_len-1)).*decimalval(k)+ll(1); % Refer to David coley introduction to genetic algorihms
         elseif rem(k,2)==0
         decimalval(k)=bin2dec(genomes(:,:,k));
         realval(k)= ((ul(2)-ll(2))/(2.^genome_len-1)).*decimalval(k)+ll(2); % Refer to David coley introduction to genetic algorihms
         elseif k==11
         decimalval(k)=bin2dec(genomes(:,:,k));
         realval(k)= ((ul(3)-ll(3))/(2.^genome_len-1)).*decimalval(k)+ll(3);
        end
        end 
end

%binary to decimal conversion
function  decimal= bin2dec(genome)   
    global genome_len 
    decimal=0;
    
    for b=1:genome_len
            dec_digit = (2^(genome_len-b))*genome(b); 
            decimal=dec_digit +decimal;
    end
end




