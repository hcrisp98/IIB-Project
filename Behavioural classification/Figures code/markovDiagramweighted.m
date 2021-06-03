
bv = ones(size(ZFallingMarkov))*2;
bv(~isnan(ZInteractingMarkov))=1;
if length(ZInteractingMarkov(1,:))==3
    bv(~isnan(sum(ZInteractingMarkov,2)),:)=3;
end
bv(~isnan(ZFallingMarkov))=4;



tWindow=30;
BVector=[];
c=1;

[rws,cls]=size(bv);

for i=(tWindow+1):tWindow:rws
    for j=1:cls
        if max(bv((i-tWindow):i,j)==4)==1
            BVector(c,j)=4;
        else
            BVector(c,j)=mode(bv((i-tWindow):i,j));
        end
    end
    c=c+1;
end




%Same weighted balloons
graphs = {};
SS={};
TT={};
WW={};
for bln = 1:cls
    
    tMatrix = zeros([4 4]);
    for i=2:length(BVector)
        if BVector(i-1,bln)==4
            tMatrix(4,4)=...
                tMatrix(4,4)+1;
        else
            tMatrix(BVector(i-1,bln),BVector(i,bln))=...
                tMatrix(BVector(i-1,bln),BVector(i,bln))+1;
        end
    end
    
    for sor = 1:length(tMatrix(:,1))
        if sum(tMatrix(sor,:))>0
            tMatrix(sor,:)=tMatrix(sor,:)/sum(tMatrix(sor,:));
        end
    end
    
    tMatrix = round(tMatrix*10000)/10000;
    tMatrix  =  tMatrix *100;
    source = [];
    target = [];
    weights = [];
    
    for sor = 1:length(tMatrix(:,1))
        for tar = 1:length(tMatrix(1,:))
            if tMatrix(sor,tar)>0
                source(end+1)=sor;
                target(end+1)=tar;
                weights(end+1)=tMatrix(sor,tar);
            end
        end
    end
    
    names = {'I1','S','I2','F'}';
    G=digraph(source,target,weights,4);
    G.Nodes.Name=names;
    graphs{bln}=G;
    SS{bln}=source;
    TT{bln}=target;
    WW{bln}=weights;
end



% graphs = {};
% for bln = 1 %:cls
%     
%     tMatrix = zeros([4 4]);
% 
%     for i=2:length(BVector)
%         
%         for j=bln
%             
%             if BVector(i-1,j)==4
%                 
%                 tMatrix(4,4)=...
%                     tMatrix(4,4)+1;
%             else
%                 tMatrix(BVector(i-1,j),BVector(i,j))=...
%                     tMatrix(BVector(i-1,j),BVector(i,j))+1;
%             end
%         end
%         
%     end
%     
%     
%     for sor = 1:length(tMatrix(:,1))
%         tMatrix(sor,:)=tMatrix(sor,:)/sum(tMatrix(sor,:));
%     end
%     
%     tMatrix = round(tMatrix*1000)/1000;
%      tMatrix  =  tMatrix *100;
%     source = [];
%     target = [];
%     weights = [];
%     
%     for sor = 1:length(tMatrix(:,1))
%         for tar = 1:length(tMatrix(1,:))
%             if tMatrix(sor,tar)>0
%                 source(end+1)=sor;
%                 target(end+1)=tar;
%                 weights(end+1)=tMatrix(sor,tar);
%             end
%         end
%     end
%     % G=digraph(tMatrix)
%     names = {'I1','S','I2','F'}';
%     G=digraph(source,target,weights,4);
%     G.Nodes.Name=names;
%     graphs{bln}=G;
% end

