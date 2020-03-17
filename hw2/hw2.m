

load handel
S = y';
n = length(v );
t2 = (1:length(v))/Fs;
L = t2(end);
t = t2(1:n); 
k=(2*pi/L)*[0:n/2 -n/2:-1]; 
ks=fftshift(k);

tau = 3;
a = 1;
g = exp(-a*(t-tau).^2);
Sg = g.*S;
Sgt = fft(S);

figure(1)
subplot(2,1,1)
plot(t,S,'k',t,g,'m');
set(gca,'Fontsize',16), xlabel('Time (t)'), ylabel('S(t)')

subplot(2,1,2) 
plot(k, Sgt,'r');
set(gca,'Fontsize',16)
xlabel('frequency (\omega)'), ylabel('FFT(S)')

tslide=0:0.1:10;
Sgt_spec = zeros(length(tslide),n);
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    Sg=g.*S; 
    Sgt=fft(Sg); 
    Sgt_spec(j,:) = fftshift(abs(Sgt)); % We don't want to scale it
end

figure(2)
pcolor(tslide,ks,Sgt_spec.'), 
shading interp 
set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)