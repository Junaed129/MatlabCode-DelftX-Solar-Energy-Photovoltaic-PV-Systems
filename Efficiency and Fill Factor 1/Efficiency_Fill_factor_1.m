%'PVModuleData.mat' file contains the cell array 'PVModule'. The cell array 'PVModule' consists 
%of one structure. The structure contains six fields, namely: Voc, Isc, Vmpp, Impp, Length and Width. 
%The units of the imported variables are in Volt, Ampere and Meter!
% As an example we calculate the fill factor by obtaining the single values of the fields from the structure of the cell array.
% The index {1} here refers to the first (and in this case also the only) structure in the cell array
% And the '.Vmpp' refers to the field in the chosen structure
clc
clear all 
close all
% Load the PVModuleData.mat file containing the cell array 'PVModule'.
load('PVModuleData.mat','PVModule');

%%If you want to write the data in excel File
val= (struct2table(PVModule{:}))
writetable(val,'Data.csv')
% Transpose the table
%val2=rows2vars(val)
%writetable(val2,'new_file1.csv')

FF = PVModule{1}.Vmpp*PVModule{1}.Impp / (PVModule{1}.Voc*PVModule{1}.Isc) * 100    % This line results in a single value expressed in percentage
Eff=( PVModule{1}.Vmpp*PVModule{1}.Impp * 100 ) /(PVModule{1}.Length*PVModule{1}.Width * 1000  )
 
