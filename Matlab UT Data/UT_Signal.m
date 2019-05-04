classdef UT_Signal
% This file is the definition of a data class called 'UT_Signal'
% 'UT_Signal' is used to store a raw UT data signal collected from
% the AMPL's Acquisition Logic AL8xGTe digitizer board
%
% Create: April 2018
%         Kartik Vasudev
%         kvasudev@ualberta.ca
%         Dept. of Chem. and Materials Engineering
%         University of Alberta
    properties % Properties for storing data about a UT signal
        Steel_Type % Store the type of steel
        Sample_Name % Store information about the sample
        Other % Other useful information about the signal
        Date_Saved
        Signal % 1xN data vector containing the signal
        Duration % Time length (in us) of the signal
        Axis_Length % Interger, stating how many data points in the signal
    end
    methods
    end
end
