function [x,y]=match_point(input,y)
% cor=sample>0;
% samc=sample.*cor;
samc=ones(9,13,3);
[hi,wi,~]=size(input);
% sample=52*141
minerr=10000;mini=0;minj=0;
for i=350:3:hi/2+50
    for j=50:3:wi-40
        ins=input(i-4:i+4,j-6:j+6,:);
        err=abs(sum(sum(sum( ins-samc ))));
        if err<minerr && sum(abs(input(i+10,j+17,:)-ins(5,7,:)))>0.3 ...
                && sum(abs(input(i-10,j+17,:)-ins(5,7,:)))>0.3...
                 && sum(abs(input(i+10,j-17,:)-ins(5,7,:)))>0.3...
                  && sum(abs(input(i-10,j-17,:)-ins(5,7,:)))>0.3...
                  && sum(abs(input(i-10,j,:)-ins(5,7,:)))>0.3...
                  && sum(abs(input(i,j-17,:)-ins(5,7,:)))>0.3...
                  && sum(abs(input(i+10,j,:)-ins(5,7,:)))>0.3...
                  && sum(abs(input(i,j+17,:)-ins(5,7,:)))>0.3
            minerr=err;mini=i;minj=j;
        elseif err>10*minerr
            break;
        end
    end
end
if mini~=0
    newr=mini;newc=minj;
    for i=newr-3:newr+3
       for j=newc-3:newc+3
           ins=input(i-4:i+4,j-6:j+6,:);
           err=sum(sum(sum(abs( ins-samc ))));
           if err<minerr
              minerr=err;mini=i;minj=j;
           end
       end
    end
    if minerr<20 && abs(minj-y)>40   %abs(sum(sum(sum(samc(71,25,:)-input(mini,minj,:)))))<0.2
        %上下左右对称性
        leftx=0;rightx=0;
        while leftx<15 && sum(abs(input(mini,minj)-input(mini-leftx,minj)))<0.2
            leftx=leftx+1;
        end
        while rightx<15 && sum(abs(input(mini,minj)-input(mini+rightx,minj)))<0.2
            rightx=rightx+1;
        end
        if leftx>=15 || rightx>=15 || abs(leftx-rightx)>1
            flag=0;
        else
            topy=0;buty=0;
            while topy<10 && sum(abs(input(mini,minj)-input(mini,minj-topy)))<0.2
                topy=topy+1;
            end
            while buty<15 && sum(abs(input(mini,minj)-input(mini,minj+buty)))<0.2
                buty=buty+1;
            end
            if buty>=10 || topy>=10 || abs(buty-topy)>1
                flag=0;
            else
                flag=1;
            end
        end
    else
        flag=0;
    end
    if flag==1
        x=mini;y=minj;
    else
        x=0;y=0;
    end
else
    x=0;y=0;
end 
end