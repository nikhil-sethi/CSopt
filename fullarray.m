function cd=fullarray(x,y)
global n
%%mirroring points clockwise direction

cd(1:n,1)=x;  cd(1:n,2)=y;
cd(n+1:2*n,1)=x; cd(n+1:2*n,2)=2*pi-y;
cd(2*n+1:3*n,1)=x; cd(2*n+1:3*n,2)=pi-y;
cd(3*n+1:4*n,1)=x; cd(3*n+1:4*n,2)=pi+y;
end
