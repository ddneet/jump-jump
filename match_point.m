function [x,y]=match_point(input)
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
        if err<minerr && abs(sum(sum(sum( input(i-10,j-17)-ins(5,7) ))))>0.3 ...
                && abs(sum(sum(sum( input(i+10,j+17)-ins(5,7) ))))>0.3...
                 && abs(sum(sum(sum( input(i-10,j+17)-ins(5,7) ))))>0.3...
                  && abs(sum(sum(sum( input(i+10,j-17)-ins(5,7) ))))>0.3
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
           err=abs(sum(sum(sum( ins-samc ))));
           if err<minerr
              minerr=err;mini=i;minj=j;
           end
       end
    end
    if minerr<20 %&& abs(sum(sum(sum(samc(71,25,:)-input(mini,minj,:)))))<0.2
%         x=720-minj;y=mini+55;
        x=mini;y=minj;
    else
        x=0;y=0;
    end
else
    x=0;y=0;
end 
end