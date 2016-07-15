function Io = gab2d(I,sigmax,sigmay,u,v)

% Creating the 2D Gabor Filter
m=fix(sigmax);
n=fix(sigmay);
for x=-m:m
for y=-n:n
t=((x*x)/(sigmax*sigmax))+((y*y)/(sigmay*sigmay));
t=(exp(-0.5*t))/(2*pi*sigmax*sigmay);
gfr(m+x+1,n+y+1)=t*cos(2*pi*(u*x+v*y));
gfi(m+x+1,n+y+1)=t*sin(2*pi*(u*x+v*y)); 
end
end

% Computing the Output Image
Ir=conv2(I,double(gfr),'same');
Ii=conv2(I,double(gfi),'same');
Io=sqrt(Ir.*Ir+Ii.*Ii);
