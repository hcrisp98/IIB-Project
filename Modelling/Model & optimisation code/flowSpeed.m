function [V] = flowSpeed(meanFlowVelocity,rFlow,r)

% if r<rflow-rb
%     V=meanFlowVelocity;
% elseif r<rflow
%     V= meanFlowVelocity*(abs(rflow-r)+rb)/(2*rb);
% elseif r==rflow
%     V=meanFlowVelocity/2;
% elseif r<rflow+rb
%     V= meanFlowVelocity*(rb-(r-rflow))/(2*rb);
% else
%     V=0;
% end


V =  meanFlowVelocity*normpdf(r,0,rFlow);

end

