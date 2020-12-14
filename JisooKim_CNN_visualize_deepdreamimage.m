
%% Load image data
clc;
clear;

digitDatasetPath = fullfile('H:\image_psd3');
digitData = imageDatastore(digitDatasetPath,...
    'IncludeSubfolders',true,'LabelSource','foldernames');


%% Count the Label
labelCount = countEachLabel(digitData)

trainNumFiles = 180;
[trainDigitData,valDigitData] = splitEachLabel(digitData,trainNumFiles,'randomize');



%% Define Network Architecture
% Define the convolutional neural network architecture.

layers = [
    imageInputLayer([128 128 3])
    
    convolution2dLayer(16,128,'Padding',1)  % 16 128
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(32,16,'Padding',1)   % 32 16
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(8,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(4,'Stride',2)

    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];



%% Options
options = trainingOptions('sgdm',...
    'MaxEpochs',30, ... % 10
    'ValidationData',valDigitData,...
    'ValidationFrequency',30,... % 30 
    'Verbose',true,...
    'Plots','training-progress','ExecutionEnvironment','cpu');

net = trainNetwork(trainDigitData,layers,options);



%% Get the final training accuracy and validation accuracy

predictedLabels = classify(net,valDigitData);
valLabels = valDigitData.Labels;

validation_accuracy = sum(predictedLabels == valLabels)/numel(valLabels);


% Get training accuracy
predtrainLabels = classify(net,trainDigitData);
trainLables = trainDigitData.Labels;

training_accuracy = sum(predtrainLabels == trainLables)/numel(trainLables);


fprintf('The final training accuracy is %f\n', training_accuracy(1))
fprintf('The final validation accuracy is %f\n', validation_accuracy(1))


%% Visualize the features (Conv1)

% layer 2 is corresponding to convolution1
layer = 2; name = net.Layers(layer).Name;

channels = 1:32;
I = deepDreamImage(net,layer,channels,'PyramidLevels',1);

figure(1);
I = imtile(I,'ThumbnailSize',[64 64]);
imshow(I); title(['Layer ',name,' Features']);

%% Visualize the features (Conv2)

% layer 6 is corresponding to convolution2
layer2 = 6; channels2 = 1:16;
I2 = deepDreamImage(net,layer2,channels2,'PyramidLevels',1);

figure(2);
I2 = imtile(I2,'ThumbnailSize',[64 64]);
imshow(I2); name2 = net.Layers(layer).Name;
title(['Layer ',name2,' Features']);


%% Visualize the features (Conv3)

% layer 10 is corresponding to convolution3
layer3 = 10; channels3 = 1:16;
I3 = deepDreamImage(net,layer3,channels3,'PyramidLevels',1);

figure(3);
I3 = imtile(I3,'ThumbnailSize',[64 64]);
imshow(I3); name3 = net.Layers(layer).Name;
title(['Layer ',name3,' Features']);


%% Visualize the features (Conv3)

% layer 10 is corresponding to convolution3
layer3 = 14; channels3 = 1:2;
I3 = deepDreamImage(net,layer3,channels3,'PyramidLevels',1);

figure(4);
I3 = imtile(I3,'ThumbnailSize',[64 64]);
imshow(I3); name3 = net.Layers(layer).Name;
title(['Layer ',name3,' Features']);


