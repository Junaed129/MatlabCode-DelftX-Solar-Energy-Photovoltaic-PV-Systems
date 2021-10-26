clc
clear all
close all
% First we load the '.mat' file containing the hourly meteorological data of an entire year per hour into MATLAB's workspace 
% The following lines are used to load the meterological data. The variable location_filename can be modified to experiment with data for other locations. 
location_filename = 'Delft.mat'; %You can replace 'Delft.mat' by: 'Buenos_Aires.mat'; 'New_Dehli.mat'; or 'Vancouver.mat'
load(location_filename,'As','as','DHI','DNI','GHI');% Loading vectors 'As', 'as', 'DHI', 'DNI' and 'GHI'   
% As (Sun Azimuth) as(Sun Altitude) DNI (Direct Normal Irradiance)
% DHI(Direct horizontal irradiance) GHI(Global Horizontal Irradiance)
 
alpha = 0.20;                 % Albedo coefficient
Am = 0:2:360;                % Initializing PV Module Azimuth range from 0-360 degrees in steps of 2 degrees as a row vector
theta = 0:2:90;              % Initializing PV Module tilt angle range from 0-90 degrees in steps of 2 degrees as a row vector
am = 90-theta ;
% PV Module altitude range as a row vector
% % Create 

for a = 1:1:length(am) %'a' is the index to iterate through vector 'am'
     for b = 1:1:length(Am) %'b' is the index to iterate through vector 'Am'
%         % Direct Irradiance
          cos_AOI = cosd(am(a)).*(cosd(as)).*(cosd(Am(b) - As)) + sind(am(a)).*sind(as); % Calculate the cosine of the angle of incidence for every hour of the year for a specific module tilt and orientation
          Gdirect = cos_AOI .* DNI  ;
          Gdirect(Gdirect<0) = 0;   % This makes all the negative Direct Irradiance on the PV module as zero.

         % Isotropic Diffuse Irradiance
           SVF = ((1+cosd(theta(a))))/2 ;
           Gdiffuse = SVF .* DHI;
    
      % Irradiance due to effect of albedo
          Galbedo = alpha .* (1-SVF).*GHI;
                 
       % Total Irradinace
          Gm = Gdirect + Gdiffuse + Galbedo;
  
        % Total Energy incident on PV module surface for the whole year 
         %Em(a,b) = sum(Gm(:))*(10^-3)*365*24;
          Em(a,b) = sum(Gm(:))*(10^-3);
     end
end
[Em_max,I] = max(Em(:))
% s=[length(am),length(Am)];
% maximum = max(max(A));
[x,y]=find(Em==Em_max)
Opt_Am = Am(y)
Opt_theta = theta(x)

%%%%%%%%%%%%%%%%%%%% Plotting (Uncomment the below script to visualize your model after you sucessfully run your script) %%%%%%%%%%%%%%%%%%%% 

[X,Y] = meshgrid(Am,theta);  % Creating a grid of the PV Module Azimuth and altitude angles
contourf(X,Y,(Em./1000),100)  % 1000 is divided to convert Em into kWh/m^2 unit.
colormap jet
shading interp
view(0,90)

c = colorbar;
c.Label.String = 'Irradiation (kWh/m^2)';
c.Label.FontSize = 20;

ax = gca; % current axes
ax.XTick = [0:60:360];
ax.FontSize = 20;
ax.XLabel.String  = 'Module Azimuth (A_{m})';
ax.YLabel.String  = 'Module Tilt (\theta_{m})';
ax.YTick = [0:10:90];
ax.TickLength = [0 0];
axis square 


