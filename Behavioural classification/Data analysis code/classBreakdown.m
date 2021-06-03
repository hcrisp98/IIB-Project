
function [result lifetimes]= classBreakdown2(trajectory1, trajectory2, thresholdFalling, thresholdInteracting)

% classify behaviours into falling, stable or interacting

trajectory1=trajectory1/187.5
trajectory2=trajectory2/187.5

falling= 0;
interacting= 0;
stable= 0;

classOrder = []

for i=1:30:8998;
    if trajectory1(i) < thresholdFalling || trajectory2(i) < thresholdFalling;
        falling = falling+1;
        classOrder(i) = 1;
    elseif abs(trajectory1(i)-trajectory2(i))<thresholdInteracting;
        interacting = interacting+1;
        classOrder(i) = 2;
    else;
        stable = stable+1;
        classOrder(i) = 3;
    end
end

classOrder=nonzeros(classOrder)'

class= [falling interacting stable]

% create state transition probability matrix 

seqCount = zeros(3,3);
for i=1:3
for j=1:3
    seqCount(i,j)= sum(strfind(classOrder,[i j])~=0)/(numel(classOrder)-1);
end
end

transitionMatrix = bsxfun(@rdivide,seqCount,sum(seqCount,2))

markovChain = dtmc(transitionMatrix)
stateNames = ["Falling" "Interacting" "Stable"];
markovChain.StateNames = stateNames;
figure;
graphplot(markovChain, 'LabelEdges', true);
title('State Transition Probabilities')

% split into lifecycles with falling as the breakpoint

V = classOrder;
idx = [find(V == 1) length(V)+1];                   % Find Zeros & End Indices
didx = diff([0 idx])-1;                             % Lengths Of Nonzero Segments
V0 = V;                                             % Create ‘V0’ (Duplicate Of ‘V’)
V0(V0 == 1) = [];                                   % Delete Zeros
C = mat2cell(V0, 1, didx);                          % Create Cell Array
result = C(cellfun(@(x) size(x,2)~=0, C));          % Delete Empty Cells
result=result';                                     % contains the behaviour order for each lifecycle

% find mean lifecycle length

lifetimes=[];

for i=1:size(result,1)
    lifetimes(i)=length(result{i, 1});
end

lifetimes=mean(lifetimes);


end