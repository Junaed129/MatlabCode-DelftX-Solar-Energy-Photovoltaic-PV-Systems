% First we load the '.mat' file containing the hourly meteorological data for a single day per hour into MATLAB's workspace 
% The following lines are used to load the meterological data.  
load('Locationdata.mat','HourlyData');  
% 'LocationData.mat file contains the cell array 'HourlyData'. The cell array 'HourlyData' contains 10 structures, 
% namely 'hour' = {1}, 'As' = {2} , 'as' = {3}, 'DNI' = {4}, 'DHI' = {5}, 'GHI' = {6},
% 'SF_Site 1' = {7}, 'SF_Site 2' = {8}, 'SF_Site 3' {9}, 'SF_Site 4' = {10}
% Each structure contains 24 fields representing the hours in a single day. Field 1 corresponds to midnight. 

% Enter Input Values
theta = 35;       % This is the tilt angle of the PV module [degrees]
Am = 180;          % This is the azimuth of the PV module [degrees]
alpha = 0.4;      % This is the albedo of surface for the four sites
SVF = [0.8151;0.6304;0.6077;0.3661];  % These are the Sky view factor values for each of the four sites in chronological order.

% Calculate the highest energy incident on the PV module, for the day, among the four sites
% First step is to calculate the Angle of Incidence hourly for the PV module for all four sites. Thsi corresponds to the orientation of the pv module.

for i = 1:1:4 % Loop to iterate through the four Sites  
    cos_AOI = (cosd(90-theta).*cosd(HourlyData{3}).*cosd(180-HourlyData{2})) + (sind(90-theta).*sind(HourlyData{3}));
      Gdirect = cos_AOI .* HourlyData{4}.*HourlyData{6+i}  ;
      Gdirect(Gdirect<0) = 0;   % This makes all the negative Direct Irradiance on the PV module as zero.
% Isotropic Diffuse Irradiance
      Gdiffuse = SVF(i) .* HourlyData{5};
% Irradiance due to effect of albedo
          Galbedo = alpha .* (1-SVF(i)).*HourlyData{6};           
% Total Irradinace
          Gm = Gdirect + Gdiffuse + Galbedo;
% Total Energy incident on PV module surface for the whole year 
          Em(i) = sum(Gm(:));
end
Em
Em_max=max(Em(:))
    
   
% Hint:
    % Extract the DNI, DHI and GHI data for the day from the HourlyData file
    % Next extract the shading factor values for Site 1. 
        %% (Note '0' means Sun Fully shaded by building and '1' means sun not shaded.)
    % Then Calculate Gm for each hour of the day for the 1st site. 
        %% Remember to include the shading factor values and the correct sky view factor in your 'Gm' calculations.
    % Next calculate Em for this site.
    % Repeat the last three steps for the remaing sites.
    % Finally store your final result in the variable Em_max




