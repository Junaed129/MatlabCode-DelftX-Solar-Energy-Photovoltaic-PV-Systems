clc
clear all
close all
% Loading the input files into MATLAB
load('SystemData.mat','System'); 
% SystemData.mat file contains the cell array 'System'. The cell array 'System' consists of four structures.
% Each structure contains of five fields, namely: ChargeController, Battery, Inverter, Grid, and DieselGenerator.
% All imported efficiency values are expressed in percentage!

load('LoadData.mat','Load');        
% LoadData.mat file contains cell array 'Load'. The cell array 'Load' consists of only one structure.
% Each structure contains the following 9 fields: Bulb, Laptop, Iron, WashingMachine, Heater, AirConditioner,  Fan, TV, and DesktopComputer    
% All imported power values are expressed in Watts!  
% Module Input data 

% Module input data
Vmpp = 57.3;
Impp = 5.71;

% calculate the power supplied by the PV modules in Watt (8 in total)
Pmpp = Vmpp * Impp;

% Now extract the efficiencies of the component(s) in the stand-alone PV system (with storage)
% Bare in mind that the imported efficiency values are expressed in percentage.
Eff_component_inv = System{2}.Inverter;
Eff_component_cc = System{2}.ChargeController;
Eff_component_batt = System{2}.Battery;


% calculate the power supplied by the PV system.(includes the PV modules and the charge controller)
P_system = 8* (Pmpp *Eff_component_cc)/100 ;

% extract the power consumption of the loads from the "LoadData.mat" file 
P_washingmachine = Load{1}.WashingMachine;
P_heater =Load{1}.Heater;
P_load1 = P_washingmachine + P_heater ;

% 1st hour
hour1 = 1;
if (P_system > P_load1 *100/Eff_component_inv) % check whether the system power is greater than the load power for this time. Calculate the battery power accordingly
% calcualte how much power is fed to or received by the battery.
    P_battery_1 = ( P_system - (P_load1 * 100/Eff_component_inv) ) *(Eff_component_batt/100);
else 
    P_battery_1 = ( P_system - (P_load1 * 100/Eff_component_inv) ) / ((Eff_component_batt/100)*(Eff_component_cc/100));
end
E_battery_1 = hour1 * P_battery_1
% 2nd hour
hour2 = 1;
% extract the power consumption of the loads from the "LoadData.mat" file 
P_TV = Load{1}.TV;
P_bulb =Load{1}.Bulb;
P_iron =Load{1}.Iron;
P_ac = Load{1}.AirConditioner;
P_labtop = Load{1}.Laptop;
P_load2 = P_TV + P_bulb + P_iron + P_ac + P_labtop ;

if (P_system > P_load2 *100/Eff_component_inv) % check whether the system power is greater than the load power for this time. Calculate the battery power accordingly
% calcualte how much power is fed to or received by the battery.
    P_battery_2 = ( P_system - (P_load2 * 100/Eff_component_inv) ) *(Eff_component_batt/100);
else 
    P_battery_2 = ( P_system - (P_load2 * 100/Eff_component_inv) ) / ((Eff_component_batt/100)*(Eff_component_cc/100));
end
% Calculate the net energy of the batteries for the two hours. Express it in [Wh]
E_battery_2 = hour2 * P_battery_2
E_battery = E_battery_1 + E_battery_2
