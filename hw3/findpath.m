function [displacement, X] = findpath(data, on)
    numFrames1_1 = size(data, 4);
    %Y = uint8(zeros(480, 640, 226));
    X = zeros( 480 * 640, 226);

    for j = 1:numFrames1_1
        i = data(:,:,:,j);
        gray = rgb2gray(i);
        X(:, j) = reshape(gray,[1, 480 * 640]);
end

for i = 1:480*640
    X(i, :) = X(i, :) - mean(X(i, :));
end
width = 70;
height = 100;
figure(1)
P1 = zeros(2, numFrames1_1);
for j = 1:numFrames1_1
    image = reshape(X(:,j),[480, 640]);
    kernel = ones(height, width);
    pimage = abs(image);
    pimage(1:160,1:680) = 0;
    output = conv2(kernel, pimage);
    maxval = max(output(:));
    [y, x] = find(output == maxval);
    y = y - height;
    x = x - width; 
    P1(:, j) = [y, x];
    if on == 1
        subplot(2,2,1) 
        imagesc(image);
        axis equal
        hold on
        rectangle('Position',[x,y,width, height],'Edgecolor', 'r');
        hold off
        drawnow
        subplot(2,2,2)
        i = data(:,:,:,j);
        imshow(i);
        hold on
        rectangle('Position',[x,y,width, height],'Edgecolor', 'r');
        hold off
        drawnow
    end
end
displacement = sqrt(P1(1,:).^2 + P1(2,:).^2);
displacement = filloutliers(displacement,'makima');
if on == 1
    figure(3)
    plot(1:length(displacement), displacement);
end
end


