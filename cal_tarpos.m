function [x,y]=cal_tarpos(input,px,py,id)
input=input(200:size(input,1),:,:);
DT=canny_edge(input);
for i=px-70-200-55:px+70-200-55  %
    for j=py-26:py+26
        DT(i,j)=0;
    end
end
[nony,nonx]=find(DT==1);
stay=min(nony);
cx=find(DT(stay,:)==1);
cerx=round(mean(cx));
if max(size(cx))<10 && id<150
    DT([stay:stay+50],cerx)=0;
end
cery=min(find(DT(:,cerx)==1))+stay;
cery=cery/2;
y=cerx;x=cery+200;
end