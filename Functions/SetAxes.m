function axes_obj = SetAxes(axes_obj,plot_title,x_label,y_label,fontsize_axes,fontsize_title,fontname)
% SetAxes is used to set the plot title, axis titles, font sizes and fonts
% of an ultrasonic plot.
%
% Inputs:       fig - handle to the figure to adjust
%               plot_title - STRING with the desired plot title
%               fontsize_axes - specify the font size of axis titles
%               fontsize_title - specify the font size of the title
%               fontname - set the font of all plot elements
% Outputs:      fig - handle to the new and improved figure

% Set the ratio between axis titles and axis number
axis_Ratio = 1.5;

% Set axis titles
set(axes_obj.XLabel,'String',x_label);
set(axes_obj.YLabel,'String',y_label);

set(axes_obj,'FontSize',fontsize_axes);     % Set axis font size
set(axes_obj,'FontName',fontname);      % Set font
set(axes_obj,'LabelFontSizeMultiplier',axis_Ratio); % Set ratio 

set(axes_obj.Title,'String',plot_title);          % Set title

set(axes_obj.Title,'FontSize',fontsize_title);  % Set title font size
set(axes_obj.Title,'FontWeight','normal'); % Removes bold from title

end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a