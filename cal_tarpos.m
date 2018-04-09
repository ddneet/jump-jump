function [x,y]=cal_tarpos(input)
DT=canny_edge(input(200:size(input,1),:));
% DT=imrotate(DT,-90);
[nony,nonx]=find(DT==1);
stay=min(nony);
cx=find(DT(stay,:)==1);
cerx=round(mean(cx));
DT([stay:stay+50],cerx)=0;
cery=min(find(DT(:,cerx)==1))+stay;
cery=cery/2;
y=cerx;x=cery+200;
end