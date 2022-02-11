clear
clc
close all
set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth', 2);
nx=50;
%nx=19;
ny=50;
%ny=15; 
V=zeros(nx,ny);
G=sparse(nx*ny,nx*ny);
hb=1.054571817e-34;
m=9.11e-31;
x=linspace(0,1,nx);
dx=x(2)-x(1);
C=-hb^2/2/m;
for i =1:nx
    for j=1:ny
        n = j+(i-1)*ny;
       if i==1 || j==1 || i==nx || j==ny
            G(n,n)=1;
            
        else 
            nxm= j+(i-2)*ny;
            nxp=j+(i)*ny;
            nym=j-1+(i-1)*ny;
            nyp=j+1+(i-1)*ny;
            
            G(n,nxm)=1;
            G(n,nxp)=1;
            G(n,nyp)=1;
            G(n,nym)=1;
            G(n,n)=-4;
            %G(n,n)=-2;
       end       
       
    end
end
figure (1)
spy(G)
hold off

nmodes=9;
[E,D]=eigs(G,nmodes,'SM');
figure (2)
plot(diag(D));
title('EigenValues')

np=sqrt(nmodes);
figure (3)
for k=1:nmodes
    P=E(:,k);
    for i=1:nx
        for j=1:ny
            n=j+(i-1)*ny;
            V(i,j)=P(n);
        end
       
    end
    subplot(np,np,k), surf(V); shading interp
    title(['EV=', num2str(D(k,k))])
end
