function data = song_wavelet(songs)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = songs;
for i=1:n
    [cA,cD] = dwt(songs[:,i], 'haar');
    
end

