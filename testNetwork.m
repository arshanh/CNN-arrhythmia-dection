function testNetwork(net, test_x, test_y)
% This script tests the accuracy of a trained network on testing data
% 

% Input paramters (arguments) are:
%   net: trained neural network
%   test_x: 4-D double containing the input data in the following form
%       [128 1 1 numberOfReadings]
%   test_y: 1-D Categorial containing the signal labels
%       [numberOfReadings 1]

% Output values returned are:
%   accuracy of network is outputed to command window

% Author: 06/15/17 - by Arshan Hashemi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
YTest = classify(net, test_x);

accuracy = sum(YTest == test_y)/numel(test_y)
