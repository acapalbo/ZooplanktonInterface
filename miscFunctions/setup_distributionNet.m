function net = setup_distributionNet(numFeatures,numHidden)
net = dlnetwork;
tempNet = [
    featureInputLayer(numFeatures,"Name","featureinput")
    dropoutLayer(0.5,"Name","dropout")
    fullyConnectedLayer(numHidden,"Name","fc")
    tanhLayer("Name","tanh")
    batchNormalizationLayer("Name","batchnorm")];
net = addLayers(net,tempNet);

tempNet = [
    fullyConnectedLayer(numHidden,"Name","fc_1")
    geluLayer("Name","gelu")];
net = addLayers(net,tempNet);

tempNet = [
    fullyConnectedLayer(numHidden,"Name","fc_2")
    eluLayer(1,"Name","elu")];
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(2,"Name","depthcat")
    fullyConnectedLayer(numHidden,"Name","fc_3")
    batchNormalizationLayer("Name","batchnorm_1")
    tanhLayer("Name","tanh_1")
    fullyConnectedLayer(2,"Name","fc_4")
    softmaxLayer("Name","softmax")];
net = addLayers(net,tempNet);

% clean up helper variable
clear tempNet;
net = connectLayers(net,"batchnorm","fc_1");
net = connectLayers(net,"batchnorm","fc_2");
net = connectLayers(net,"elu","depthcat/in1");
net = connectLayers(net,"gelu","depthcat/in2");
net = initialize(net);
end