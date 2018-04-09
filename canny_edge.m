function DT=canny_edge(img)

[H,W] = size(img);%获取图像大小
r=1;
sigma=1*r;
gausFilter = fspecial('gaussian',[2*r+1 2*r+1],sigma);
A=imfilter(img,gausFilter,'replicate'); 

dx = [-1 0 1;-1 0 1;-1 0 1];%x方向的梯度模板
dy = [1 1 1;0 0 0;-1 -1 -1];%y方向的梯度模板

gx = conv2(A,dx,'same');%获取x方向的梯度图像.使用梯度模板进行二维卷积,结果与原图像大小相同
gy = conv2(A,dy,'same');%获取y方向的梯度图像.使用梯度模板进行二维卷积,结果与原图像大小相同
M = sqrt((gx.^2) + (gy.^2));%获取幅值图像.大小与原图像相等.(.^)表示数组乘方
a = atan2(gy,gx);%获取弧度，范围：-pi~pi
a= a*180/pi;%将弧度转换为角度，得到角度图像，与原图像大小相等.

for i = 1:H
    for j = 1:W
        if((a(i,j) >= -22.5) && (a(i,j) < 0)||(a(i,j) >= 0) && (a(i,j) < 22.5) || (a(i,j) <= -157.5) && (a(i,j) >= -180)||(a(i,j) >= 157.5)&&(a(i,j) <= 180))
            a(i,j) = 0;
        elseif((a(i,j) >= 22.5) && (a(i,j) < 67.5) || (a(i,j) <= -112.5) && (a(i,j) > -157.5))
            a(i,j) = 45;
        elseif((a(i,j) >= 67.5) && (a(i,j) < 112.5) || (a(i,j) <= -67.5) && (a(i,j) >- 112.5))
            a(i,j) = 90;
        elseif((a(i,j) >= 112.5) && (a(i,j) < 157.5) || (a(i,j) <= -22.5) && (a(i,j) > -67.5))
            a(i,j) = -45;  
        end
    end
end

Nms2 =M;%定义一个非极大值图像

for i = 3:H-2
    for j= 3:W-2
        %
        if a(i,j) == 0 && M(i,j) ~= max(M(i,j-1:j+1))
            Nms2(i,j) =0;
        elseif a(i,j) ==45 && M(i,j) ~= max([M(i,j), M(i+1,j-1),M(i-1,j+1)]) %,M(i+2,j-2),M(i-2,j+2)])%
            Nms2(i,j) = 0;
        elseif a(i,j) == 90 && M(i,j) ~= max(M(i-1:i+1,j))
            Nms2(i,j) = 0;
        elseif a(i,j) == -45 && M(i,j) ~= max([M(i,j), M(i+1,j+1), M(i-1,j-1)]) %, M(i+2,j+2), M(i-2,j-2)]) %
            Nms2(i,j) = 0;
        end;
    end;
end;

Nms=(Nms2-min(min(Nms2)))/(max(max(Nms2))-min(min(Nms2)));
DT=(Nms>0.01);
DT(:,1)=0;DT(1,:)=0;DT(H,:)=0;DT(:,W)=0;
% figure
% imshow(DT)
% DT = zeros(H,W);%定义一个双阈值图像
% 
% TH = 0.5*max(max(Nms));%高阈值
% TL = 0.3*max(max(Nms));%低阈值
% for i = 2  : H-1
%     for j = 2 : W-1
%         if (Nms(i, j) <= TL)
%             DT(i,j) = 0;
%         elseif (Nms(i, j) > TH)
%             DT(i,j) = 1 ;
%         %对TL < Nms(i, j) < TH 使用8连通区域确定
%         elseif ( Nms(i+1,j) > TH || Nms(i-1,j) > TH || Nms(i,j+1) > TH || Nms(i,j-1) > TH || Nms(i-1, j-1) > TH || Nms(i-1, j+1) > TH || Nms(i+1, j+1) > TH || Nms(i+1, j-1) > TH)
%             DT(i,j) = 1;
%         end;
%     end;
% end;
end