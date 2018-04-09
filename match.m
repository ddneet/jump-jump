function [x,y]=match(sample,input)
cor=sample<1;
samc=sample.*cor;
[hi,wi,~]=size(input);
% sample=52*141
minerr=10000;mini=0;minj=0;
for i=500:5:hi-200
    for j=50:5:wi-40
        ins=input(i-70:i+70,j-25:j+26,:).*cor;
        err=sum(sum(sum(abs(ins-samc))));
        if err<minerr
            minerr=err;mini=i;minj=j;
        elseif err>50*minerr
            break;
        end
    end
end
if mini~=0
    newr=mini;newc=minj;
    for i=newr-5:newr+5
       for j=newc-5:newc+5
           ins=input(i-70:i+70,j-25:j+26,:).*cor;
           err=sum(sum(sum(abs(ins-samc))));
           if err<minerr
              minerr=err;mini=i;minj=j;
           end
       end
    end
    if minerr<1000 && sum(abs(samc(71,25,:)-input(mini,minj,:)))<0.25 ...
            && max(abs(input(mini-70,minj-25,:)-input(mini,minj,:)))>0.2 && mini<850
%         x=720-minj;y=mini+55;
        x=mini+55;y=minj;
    else
        x=0;y=0;
    end
else
    x=0;y=0;
end 
end