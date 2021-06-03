function [fitresult] = leading(x, lead)
%CREATEFIT(X,LEAD)
%  Create a fit.
%
%  Data for 'leading' fit:
%      X Input : x
%      Y Output: lead
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 23-May-2021 13:29:08


%% Fit: 'leading'.
[xData, yData] = prepareCurveData( x, lead );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'leading' );
h = plot( fitresult, xData, yData );
legend( h, 'lead vs. x', 'leading', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'x', 'Interpreter', 'none' );
ylabel( 'lead', 'Interpreter', 'none' );
grid on


