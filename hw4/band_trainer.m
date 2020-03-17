function [result,w,U,S,V,threshold] = band_trainer(band1_com,band2_com,feature)
l = length(band1_com(1,:));
[U,S,V] = svd([band1_com, band2_com], 'econ');
bands = S * V';


U = U(:,1:feature);
band1 = bands(1:feature, 1:l);
band2 = bands(1:feature, l+1:2*l);

mb1 = mean(band1,2);
mb2 = mean(band2,2);
Sw = 0;
for i=1:l
    Sw = Sw + (band1(:, i)-mb1) * (band1(:, i)-mb1)';
end
for i=1:l
    Sw = Sw + (band2(:, i)-mb2) * (band2(:, i)-mb2)';
end
Sb = (mb1 - mb2) * (mb1 - mb2)';
[V2, D] = eig(Sb, Sw);
[~, ind] = max(abs(diag(D)));
w = V2(:,ind);
w = w/norm(w,2);
vband1=w'*band1;
vband2=w'*band2;
result = [vband1,vband2];
if mean(vband1) > mean(vband2)
    w = -w;
    vband1 = -vband1;
    vband2 = -vband2;
end

sortband1 = sort(vband1);
sortband2 = sort(vband2);
t1 = length(sortband1);
t2 = 1;
while sortband1(t1) > sortband2(t2)
    t1 = t1 - 1;
    t2 = t2 + 1;
end
threshold = (sortband1(t1) + sortband2(t2)) / 2;
close all
figure(1)
subplot(2,2,1)
hist(sortband1,30); hold on, xline(threshold, 'r');
set(gca,'Xlim',[-50 50],'Ylim',[0 10],'Fontsize',[14])
title('band1')
subplot(2,2,2)
hist(sortband2,30,'r'); hold on, xline(threshold, 'r');

set(gca,'Xlim',[-50 50],'Ylim',[0 10],'Fontsize',[14])
title('band2')
end

