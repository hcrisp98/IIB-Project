function [fracTotalTime]= findOrder(colours)

correctOrder = colours(:,3) > colours(:,6) & colours(:,6) > colours(:,9);%& colours(:,9) > colours(:,12);                  % detects amount of time in stable config
idx = find(diff([false;correctOrder(:);false]));
ida = idx(1:2:end);                            % extracts times in correct order
idb = idx(2:2:end);                            % extracts times in wrong order
dur = idb-ida;                                % duration of times in correct order
freqOrdered= nnz(dur);                          % number of times in correct order
fracTotalTime= sum(dur)/length(colours)*100;

end

