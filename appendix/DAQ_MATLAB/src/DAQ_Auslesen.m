%**************************************************************************
%   Smart Rehabilitation Thesis 2014 
%      
%   Skript zum initialisieren und auslesen des ICP-Beschleunigungssensors
%   603C01 von IMI Sensors mit der NI USB-4431 DAQ-Karte
%   
%   Reto Zurschmiede, Juni 2014
%**************************************************************************

clear all
close all
clc

% Laden des verwendeten Devices 
devices = daq.getDevices

% Port einstellen
devices(1)

% Session für NI Karte erstellen
s = daq.createSession('ni');

% Analogeingang hinzufügen
[ai0, ind0] = s.addAnalogInputChannel(devices.ID,'ai0','Accelerometer');

% Sensor initialisieren
s.Channels(ind0).Sensitivity = 100e-3;  % Sensitivität des Sensors [V/g]
ai0.Coupling = 'AC';                    % DC-Bias auskoppeln
ai0.ExcitationSource = 'Internal';      % Speisung des Sensors
ai0.ExcitationCurrent = 2e-3;           % Konstant Strom [A] 

% Abtastfrequenz einstellen [Hz]
s.Rate = 20e3;

% Aufzeichnungsdauer einstellen [s]
s.DurationInSeconds = 5;

% Daten auslesen
[data, time] = s.startForeground;

% Daten darstellen
figure 
plot(time,data)
xlabel('Time [s]')
ylabel('Acceleration [g]')