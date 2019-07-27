function [info1,info,num,new_img]=Image_boxing(img)
%img = imread('301.tif');
img2 = im2bw(img, 0.75); %img2 is a binary equivalent of img1 
[row, col] = size(img);
% figure,imshow(img2);
stats = regionprops(~img2, 'BoundingBox', 'Area');
ccNo = size(stats);%no. of components
hold on;
%figure,imshow(img2);
ccNo = ccNo(1);
info1 = zeros(ccNo, 12);
for p = 1 : ccNo
    compCoord = stats(p).BoundingBox;
    compArea = stats(p).Area;
    % rectangle('Position', compCoord, 'EdgeColor', 'r');
    x1 = ceil(compCoord(1)); %ceil(stats(1).BoundingBox;
    y1 = ceil(compCoord(2)); %ceil(stats(2).BoundingBox;
    width = compCoord(3); %stats(3).BoundingBox;
    height = compCoord(4); %stats(4).BoundingBox;
    y2 = y1 + height;
    x2 = x1 + width;
    for j = 1 : 2
        info1(p, j) = ceil(stats(p).BoundingBox(1, j));        
    end
    info1(p, 3) = x2;
    info1(p, 4) = y1;
    info1(p, 5) = x2;
    info1(p, 6) = y2;
    info1(p, 7) = x1;
    info1(p, 8) = y2;
    info1(p, 9) = ceil((x1 + x2) / 2);
    info1(p, 10) = ceil((y1 + y2) / 2);
    info1(p, 12) = stats(p).Area;
    %info(i, 13) = height * width;
end
hold off;
info = zeros(ccNo, 12);
num = ccNo;
xul = 1; yul = 2; xur = 3; yur = 4; xlr = 5; ylr = 6; xll = 7; yll = 8; cx = 9; cy = 10; lbl = 11; area = 12;
% display(num);
%info1 = sortrows(info1, 10);
for p = 1 : num
    info1(p, 11) = p;
end
sum=0;
for p=1:1:num
    sum=sum+info1(p,12);
end
hold on;
%figure,imshow(img2);
smallSize = sum/num;
smallSize=smallSize/2;
largeComps = 0;
lbl=11;
for p = 1 : num
     if info1(p, 12) >= smallSize
        largeComps = largeComps + 1;
        compCoord = stats(p).BoundingBox;
%         rectangle('Position', compCoord, 'EdgeColor', 'r');
        for j = 1 : 12
            info(largeComps, j) = info1(p, j);
        end
        info(largeComps, lbl) = largeComps; 
     end
end
hold off;
info(largeComps + 1 : num, :) = [];
allComps = num;
num = largeComps;
%display(num);
new_img=ones(size(img2));
for i=1:1:num
    for j=info(i,yul):1:info(i,yll)-1
        for k=info(i,xul):1:info(i,xur)-1
                new_img(j,k)=img2(j,k);            
        end
    end 
end
% figure,imshow(new_img);
end
