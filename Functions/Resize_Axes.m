function fig = Resize_Axes(fig)
% Resize_Axes creates a space in the bottom of a figure to place buttons
%
% Input:        fig - handle to Figure object to be adjusted
% Output:       fig - handle to the same Figure object after adjustment

% Set the relative size of the bottom margin on the figure window
% The margin will be used to house clickable buttons
MARGIN = 0.1;

% Set the outer position of the 'axes' (only Child) element of 'fig'
set(fig.Children,'OuterPosition',[0 MARGIN 1 1-MARGIN])

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a