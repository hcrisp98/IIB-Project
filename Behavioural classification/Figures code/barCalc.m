bvplot = ones(size(ZFalling))*2;
bvplot(~isnan(ZInteracting))=1;
if length(ZInteracting(1,:))==3
    bvplot(~isnan(sum(ZInteracting,2)),:)=3;
end
bvplot(~isnan(ZFalling))=4;

bvplot(and(bvplot==1,bvplot==3))

tWindow=30;
BVector=[];
c=1;

[rws,cls]=size(bvplot);

for i=(tWindow+1):tWindow:rws
    for j=1:cls
        if max(bvplot((i-tWindow):i,j)==4)==1
            BVector(c,j)=4;
        else
            BVector(c,j)=mode(bvplot((i-tWindow):i,j));
        end
    end
    
    if max(BVector(c,:)==3)>0
    BVector(c,BVector(c,:)==1)=3;
    end
    
   if max(BVector(c,:)==4)>0
    BVector(c,BVector(c,:)==3)=1;
    end
    
    
    c=c+1;
end

bvplot=reshape(BVector,[],1);
tot = length(bvplot);

%Stable
stable = length(find(bvplot==2))/tot; 

%Interact1
interact1 = length(find(bvplot==1))/tot; 

%Interact2
interact2 = length(find(bvplot==3))/tot; 

%Falling
falling = length(find(bvplot==4))/tot; 