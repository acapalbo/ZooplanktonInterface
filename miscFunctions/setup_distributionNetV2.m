function net = setup_distributionNetV2(numBins)

net = dlnetwork;

tempNet = inputLayer([1 1 numBins 1],"SSCB","Name","input");
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv","Padding","same");
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv_1","Padding","same");
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv_2","Padding","same");
net = addLayers(net,tempNet);

tempNet = [
    concatenationLayer(1,3,"Name","concat")
    reluLayer("Name","relu")];
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv_3","Padding","same");
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv_4","Padding","same");
net = addLayers(net,tempNet);

tempNet = convolution2dLayer([3 3],32,"Name","conv_5","Padding","same");
net = addLayers(net,tempNet);

tempNet = [
    concatenationLayer(2,3,"Name","concat_1")
    tanhLayer("Name","tanh")
    batchNormalizationLayer("Name","batchnorm")
    dropoutLayer(0.5,"Name","dropout")];
net = addLayers(net,tempNet);

tempNet = transposedConv2dLayer([3 3],32,"Name","transposed-conv","Cropping","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = transposedConv2dLayer([3 3],32,"Name","transposed-conv_1","Cropping","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = transposedConv2dLayer([3 3],32,"Name","transposed-conv_2","Cropping","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(3,"Name","depthcat")
    transposedConv2dLayer([3 3],96,"Name","transposed-conv_3","Cropping","same","Stride",[3 3])
    averagePooling2dLayer([3 3],"Name","avgpool2d","Padding","same","Stride",[2 2])
    tanhLayer("Name","tanh_1")
    fullyConnectedLayer(2,"Name","fc")
    softmaxLayer("Name","softmax")];
net = addLayers(net,tempNet);

% clean up helper variable
clear tempNet;

net = connectLayers(net,"input","conv");
net = connectLayers(net,"input","conv_1");
net = connectLayers(net,"input","conv_2");
net = connectLayers(net,"conv","concat/in1");
net = connectLayers(net,"conv_1","concat/in2");
net = connectLayers(net,"conv_2","concat/in3");
net = connectLayers(net,"relu","conv_3");
net = connectLayers(net,"relu","conv_4");
net = connectLayers(net,"relu","conv_5");
net = connectLayers(net,"conv_3","concat_1/in1");
net = connectLayers(net,"conv_4","concat_1/in2");
net = connectLayers(net,"conv_5","concat_1/in3");
net = connectLayers(net,"dropout","transposed-conv");
net = connectLayers(net,"dropout","transposed-conv_1");
net = connectLayers(net,"dropout","transposed-conv_2");
net = connectLayers(net,"transposed-conv","depthcat/in2");
net = connectLayers(net,"transposed-conv_1","depthcat/in1");
net = connectLayers(net,"transposed-conv_2","depthcat/in3");
net = initialize(net);

end