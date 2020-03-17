clear; close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1];
ks=fftshift(k);
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
%{
for j=1:20
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
close all, isosurface(X,Y,Z,abs(Un),0.4)
axis([-20 20 -20 20 -20 20]), grid on, drawnow

end
%}
ave=zeros(n,n,n);
for j=1:20
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
ave=ave+fftn(Un);
end
ave = abs(fftshift(ave))/20;
% the expectation of noise is some value around 70, and we already know the
% highest value will be greater than 250, therefore, by seting all values
% less than 100 to be 0, we hopefully might find the central frequency.



tau=0.5;
tx=1.9895;
ty=-0.9426;
tz=0.1047;
filter = exp(-tau*((Kx - tx).^2+(Ky-ty).^2+(Kz-tz).^2));
filter=ifftshift(filter);
path = zeros(20,3);
for j=1:20
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
fftun=fftn(Un);
res=filter .* fftun;
inv=ifftn(res);
inv=abs(inv);
[mxv,idx]=max(inv(:));
[r,c,p]=ind2sub(size(inv),idx);
path(j,:) = [x(c),y(r),z(p)];
isosurface(X,Y,Z,inv, 0.2)
axis([-20 20 -20 20 -20 20]),grid on, drawnow
end
%plot3(path(:,1),path(:,2),path(:,3))

