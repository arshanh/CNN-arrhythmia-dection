function [net] = launchNetwork(data_x, target_y)
% This script makes returns a trained CNN given training data
% 

% Input paramters (arguments) are:
%   data_x: 4-D double containing the input data in the following form
%       [128 1 1 numberOfReadings]
%   target_y: 1-D Categorial containing the signal labels
%       [numberOfReadings 1]

% Output values returned are:
%   net: trained neural network

% Author: 06/15/17 - by Arshan Hashemi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

layers = [imageInputLayer([128 1], 'Normalization', 'none')
          convolution2dLayer([15 1],32)
          reluLayer
          maxPooling2dLayer([4,1]);
          convolution2dLayer([15 1],16)
          reluLayer
          maxPooling2dLayer([2,1]);
          dropoutLayer();
          fullyConnectedLayer(12);
          fullyConnectedLayer(6);
          softmaxLayer
          classificationLayer()];
      
options = trainingOptions('sgdm','MaxEpochs',50, ...
	'InitialLearnRate',0.001);

rng('default')
net = trainNetwork(data_x, target_y, layers, options);
