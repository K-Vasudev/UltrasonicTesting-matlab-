function signal_choice = Select_Signal(signal_data_structure)
% Select_Signal allows data selection from witin a 'UT_Signal' class.
% The user is prompted with a list of possible data sets from the
% ultrasonic data structure, which is a matrix of type 'UT_Signal'.
%
% Inputs:   signal_data_structure - UT_Signal CLASS structure containing
%                   ultrasonic signals and associated data
% Outputs:  signal_choice - UT_Signal CLASS structure containing the 
%                   user's desired ultrasonic signal and associated data

    % If this function is fed data NOT of class 'UT_Signal', then display
    % an error message.
    if ~strcmp(class(signal_data_structure),'UT_Signal')
        error(['The file that was selected for analysis is not of the corrrect data type. '...
            'Check input to ''UT Signal Structure\Functions\Select_Signal.m''']);
    end

% Determine the row and column size of the 'UT_Signal' matrix
structure_size = size(signal_data_structure);
% Calculate 1-D length of matrix (rows*columns)
structure_length = structure_size(1)*structure_size(2);

disp('Please select from the following list of signals')

% Create empty array of zeros, of same length as 'UT_Signal' set
is_displayed = zeros(1,structure_length);

for signal_count = 1:structure_length       % Iterate over all matrix elements
    
    % Get information from the 'UT_Signal' matrix to display to user
    steel_type = signal_data_structure(signal_count).Steel_Type;
    sample_name = signal_data_structure(signal_count).Sample_Name;
    other = signal_data_structure(signal_count).Other;
    signal_string = [steel_type ', ' sample_name ', ' other];
    
    % If the signal data is not empty, then provide it as an option 
    % to the user.
    if ~strcmp(signal_string,', , ')
        % Display info of each ultrasonic signal, along with a selection
        % number, to the user
        disp(['[' num2str(signal_count) '] - ' signal_string])
        % Keep track of which options have been displayed to the user.
        is_displayed(signal_count) = 1;
    end
end

while true      % Continue iteration until the user has selected a valid option
     % Prompt the user to choose which ultrasonic data set they wish to see
     signal_choice = int8(input('Please select a signal from the above optoins, by entering its number: '));
     % Check that selection is within possible range. This is to ensure 
     % Matlab doesn't give have an error of vector indices.
     if signal_choice>0 && signal_choice<=structure_length
         if is_displayed(signal_choice) == 1 % Make sure choice was displayed to user
             break;         % Break out of 'while' loop
         else
             disp('Signal choice must be made from the list above.')
         end
     else
         disp('Signal choice must be made from the list above.')
     end
end
    
end

% April 14, 2018
% Advanced Materials and Processing Lab
% Dept. of Chem. and Materials Engineering
% University of Alberta
% Kartik Vasudev
% kvasudev@ualberta.ca
%
% Built and run on Matlab R2018a