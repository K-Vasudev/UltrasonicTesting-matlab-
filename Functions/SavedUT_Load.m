function [workspace] = SavedUT_Load()
% SaveUT_Load loads the workspace variable containing the desired UT signal
% This function changes directory into the 'MatLab UT Data' folder
% and chooses the appropriate workspace to load. 
%
% Inputs:   none
% Outputs:  workspace - The workspace variable selected by the user

% Change to the 'Matlab UT Data' folder
Functions_Folder = cd('..\Matlab UT Data');     % Save current directory path

% Get full list of files in the 'Matlab UT Data' ending in '.mat'
workspace_list = dir('*.mat');          
disp('Please select a workspace from the following options:')   % Display in Command Window

for ws_count = 1:length(workspace_list)  % Iterate over all workspaces
    % Display workspace name, and selection number
    disp([ '(' num2str(ws_count) ') - ' workspace_list(ws_count).name])
end

while true      % Continue until appropriate selection has been made
    % Take input from user
    ws_choice = int8(input('Select workspace number: '));
    % Make sure user input is appropriate
    if ws_choice>0 && ws_choice<=length(workspace_list)
        % If user input is good, break out of 'while' loop
        break;
    else
        % If user input is not good, prompt for re-entry
        disp('Workspace choice must be from the list above.')
    end
end

% Load workspace list option selected by user
Load_workspace = load(workspace_list(ws_choice).name);
% Keep only the workspace variable 'UT_Data_Structure' for output
workspace = Load_workspace.UT_Data_Structure;

% Return to 'UT Signal Analysis' folder.
cd(Functions_Folder);
end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a

