    function cdi_pol=scale_in(cdo_pol,t)
        global  n
 %      phi=cd_sort(i,2)+atan2(cd_sort(i+1,1).*sin(cd_sort(i+1,2)-cd_sort(i,2)),cd_sort(i,1)-cd_sort(i+1,2).*cos(cd_sort(i+1,2)-cd_sort(i,2)));
        for i=1:4*n
          
         [x1,y1]=pol2cart(cdo_pol(i,2),cdo_pol(i,1));
         [x2,y2]=pol2cart(cdo_pol(i+1,2),cdo_pol(i+1,1));
        
         if i==20
            [x3,y3]=pol2cart(cdo_pol(2,2),cdo_pol(2,1));
         else
            [x3,y3]=pol2cart(cdo_pol(i+2,2),cdo_pol(i+2,1));
         end

         theta1=atan2d(y2-y1,x2-x1) 
            theta1(theta1<0)=360+theta1;
         theta2=atan2d(y3-y2,x3-x2) 
            theta2(theta2<0)=360+theta2;
         if abs(theta2-theta1)<=90
            if theta2>theta1
            theta=90-(theta2-theta1)./2;
            else
                theta=90+abs(theta1-theta2)./2;
            end
         elseif abs(theta2-theta1)>90
            if theta2>theta1
            theta=90-(theta2-theta1)./2;
            else
            theta=90+abs(theta1-theta2)./2;
            end
         end       
         
        t_mag=t/sind(theta); t_angle=(theta2+theta)*pi/180;
        r1=cdo_pol(i+1,1); 
        temp(i,1)=sqrt(r1.^2+t_mag.^2+2*r1*t_mag*cos(t_angle-cdo_pol(i+1,2)));
        temp(i,2)=cdo_pol(i+1,2)+atan2(t_mag.*sin(t_angle-cdo_pol(i+1,2)),cdo_pol(i+1,1)+t_mag.*cos(t_angle-cdo_pol(i+1,2)));
         
        end
%         cd_in=fullarray(temp(:,1),temp(:,2));
          cdi_pol=temp;  
    end