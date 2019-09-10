function fitness=fitfunc(cdo_pol,cdi_pol) 

        [xo,yo]=pol2cart(cdo_pol(:,2),cdo_pol(:,1));
        [xi,yi]=pol2cart(cdi_pol(:,2),cdi_pol(:,1));
        MOIo=mom_area(xo,yo); MOIi=mom_area(xi,yi);
        MOI=MOIo-MOIi;
        area=polyarea(xo,yo)-polyarea(xi,yi);
        
        fitness=MOI/area;
end


function MOAx=mom_area(x,y)
     global n
      MOAx=0; MOAy=0; MOAp=0;
      for i=2:4*n+1
        MOAx=MOAx+0.0833*(y(i-1).^2+y(i-1)*y(i)+y(i).^2)*(x(i-1)*y(i)-x(i)*y(i-1));      
%         MOAy=MOAy+0.0833*(x(i).^2+x(i)*x(i+1)+x(i+1).^2)*(x(i)*y(i+1)-x(i+1)*y(i));
%         MOAp=MOAx+MOAy;
      end
end
