clc
clear all
close all
load('PVData.mat','PVModule');
% As an example we calculate the fill factor for all the PV modules.
% The index {i} refers to the number of the structure that contain all the Pv modules
% And the '.Vmpp' refers to the field in the chosen structure
modules_count = length(PVModule); %Number of modules
FF = zeros(1,modules_count);%Create an empty array to store the FF values

for i=1:modules_count 
    FF(i) = 100 * PVModule{i}.Vmpp * PVModule{i}.Impp / (PVModule{i}.Voc * PVModule{i}.Isc); 
end
% Find the PV Module with the highest fill from factor from the list. 
[max_FF,idx_FF] = max(FF); % The maximum fill factor and its index in the cell array are displayed

Eff = zeros(1,modules_count);
% Remember the efficiency must be expressed as a percentage!

for i=1:modules_count   
    Eff(i)=( PVModule{i}.Vmpp*PVModule{i}.Impp * 100 ) /(PVModule{i}.Length*PVModule{i}.Width * 1000  );
end
% Pick the PV Module with the highest efficiecny from the list. 
[max_Eff,idx_Eff] = max(Eff);

fprintf("The best PV module is %d where maximum efficiency is %0.2f and maximum fill factor is %0.2f\n",idx_Eff,max_Eff,max_FF)