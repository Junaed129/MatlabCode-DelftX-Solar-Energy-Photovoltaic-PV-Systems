clc
clear all
close all
% Load the SystemData.mat file containing the cell array 'System'.
load('SystemData.mat','System'); 
% SystemData.mat file contains the cell array 'System'. The cell array 'System' consists of four structures.
% Each structure contains of five fields, namely: ChargeController, Battery, Inverter, Grid, and DieselGenerator.
% All imported efficiency values are expressed in percentage!
% Do the same for the 'LoadData.mat' file containing the cell array 'Load'.
load( 'LoadData.mat','Load')
% LoadData.mat file contains cell array 'Load'. The cell array 'Load' consists of only one structure.
% Each structure contains the following 9 fields: Bulb, Laptop, Iron, WashingMachine, Heater, AirConditioner,  Fan, TV, and DesktopComputer    
% All imported power values are expressed in Watts!        
% Module Input data 
Vmpp =57.3;
Impp =5.71;
% calculate the power supplied by the PV module
Pmpp =(Vmpp*Impp);
% Now extract the efficiencies of the component(s) in the grid connected PV system (without storage)
% The grid connected PV system without storage corresponds to the fourth structure in the cell array.
% Bare in mind that the imported efficiency values are expressed in percentage.
Eff_inverter =System{4}.Inverter;
% Calculate the power supplied by the PV system.
P_system = (Pmpp*Eff_inverter)/100;
% Extract the power consumption of the washing machine from the "LoadData.mat" file that consist of 1 structure, index {1}.
% This was also explained in exercise 2 if you want to refresh your memory.
P_washingmachine =Load{1}.WashingMachine 
% calculate how much power is fed to or received by the grid.
P_grid = P_system - P_washingmachine