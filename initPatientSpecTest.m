function [test_x, test_y] = initPatientSpecTest(recording)
% This script extracts training data from the MIT-BIH Arrythmia Database 
% Returns input and target data for the final 25 minutes of a patient
% specific recording specified by the function parameter
% 
% Output values returned are:
%   data_x: 4-D double containing the input data in the following form
%       [128 1 1 numberOfReadings]
%   target_y: 1-D Categorial containing the signal labels
%       [numberOfReadings 1]
%
% Author: 06/15/17 - by Arshan Hashemi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num = 1;
fs = 360; % sample rate for MIT-BIH Arrhytmia Database
%samples = 646400; % samples for 30 minutes
samples = 646400;

j = 1;

filename = char(recording)
[tm, signal]=rdsamp(filename, 1, samples);
signal = signal(:,1);

[ann,type,~,~]=rdann(filename,'atr',[],samples);

for k = 1 : size(ann,1)
  if ann(k) <= samples
      stop = k;
  end
end

ann = ann(1 : stop);
type = type(1 : stop);

data = zeros(1000, 128);
target(500) = char(0);

%start = 1;
%set start to 5 minutes into recording (recording ~30 minutes in length)
start = ceil(stop/6);

%if (ann(1) < 64)
%    start = 3;
%end

stop = stop - 5;

% 6 Types of beats: Normal, Paced, Left BBB, PVC, APC, RIGHT BBB
%                   N, /, L, V, A, R
for k = start : stop    
    if type(k) == 'N' || type(k) == '/' || type(k) == 'L' ||...
            type(k) == 'V' || type(k) == 'A' || type(k) == 'R'
        for i = 1 : 128
            data(j,i) = signal(ann(k) - 63 + i);
        end
        test_x(:,1,1,j) = data(j, :);
        target(j) = type(k);
        %j = j + 1;
    end
end

test_y = categorical(cellstr(target'));