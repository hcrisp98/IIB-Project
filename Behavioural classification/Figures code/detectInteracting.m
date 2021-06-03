
separation = [];
[rows, cols] = size(ZZ);
Cutoff = 220;  %mm
interactingID = NaN([rows cols]);

for i = 1:cols
    for j = 1:cols
        
        if i~=j
            vectorSepration=[X(:,i)-X(:,j), Y(:,i)-Y(:,j), Z(:,i)-Z(:,j)];
            separation=sqrt(sum(vectorSepration'.^2));
            
            window = 5;
            for t = 1:rows
                if separation(t)<Cutoff
                    interactingID(t,i)=1;
                    interactingID(t,j)=1;
                    
                    if t<(rows-window)
                        interactingID(t:(t+window),i)=1;
                        interactingID(t:(t+window),j)=1;
                    end
                end
            end
            
            
            

            
%             td=1;
%             while td < (length(interactingID(:,i))-window)
%                 
%                 if interactingID(td,i) ==1 && interactingID(td+window,i)==1
%                     interactingID(td:(td+window),i)=1;
%                     interactingID(td:(td+window),j)=1;
% %                     td=td+window;
% %                 else
%                     
%                 end
%                 
%                 td=td+1;
%             end
%             
            
%             isoWindow = 5;
%             for ii=1:length(interactingID(:,i))-isoWindow
%                 
%                 if ii>isoWindow
%                     if isnan(interactingID(ii-isoWindow,i)) && isnan(interactingID(ii+isoWindow,i))
%                         interactingID((ii-isoWindow):(ii+isoWindow),i)=NaN;
%                     end
%                 end
%             end
%             
            
            
        end
        
        
    end
end



interactingID(max(~isnan(fallingID)),:)=NaN;

ZInteracting = ZZ.*interactingID;
XInteracting = XX.*interactingID;
YInteracting = YY.*interactingID;