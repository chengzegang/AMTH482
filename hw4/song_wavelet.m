function data = song_wavelet(songs)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,n] = songs;
for i=1:n
    [cA,cD] = dwt(songs[:,i], 'haar');
    
end

