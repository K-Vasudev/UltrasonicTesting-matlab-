classdef UT_Signal
% This file is the definition of a data class called 'UT_Signal'
% 'UT_Signal' is used to store a raw ultrasonic data signal collected from
% the AMPL's Acquisition Logic AL8xGTe digitizer board

    properties % Properties for storing data about a ultrasonic signal
        Steel_Type % Store the type of steel
        Sample_Name % Store information about the sample
        Other % Other useful information about the signal
        Date_Saved
        Signal % 1xN data vector containing the signal
        Duration % Time length (in us) of the signal
        Axis_Length % Integer, stating how many data points in the signal
        Thickness % Thickness of the specimen measured where the signal is measured (in mm)
    end
    methods % Methods which can be applied to ultrasonic data set
    end
end

% Create: April 2018
%         Kartik Vasudev
%         kvasudev@ualberta.ca
%         Dept. of Chem. and Materials Engineering
%         University of Alberta
%
% Built and run on Matlab R2018a