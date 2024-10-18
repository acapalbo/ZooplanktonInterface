function net = setupDarkNet(inputSize,numOfClasses)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
net = dlnetwork;
tempNet = [
    imageInputLayer(inputSize,"Name","input","Normalization","rescale-zero-one")
    convolution2dLayer([3 3],32,"Name","conv1","Padding","same")
    batchNormalizationLayer("Name","batchnorm1")
    leakyReluLayer(0.1,"Name","leakyrelu1")
    convolution2dLayer([3 3],64,"Name","conv2","Padding",[1 0 1 0],"Stride",[2 2])
    batchNormalizationLayer("Name","batchnorm2")
    leakyReluLayer(0.1,"Name","leakyrelu2")];
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],32,"Name","conv3","Padding","same")
    batchNormalizationLayer("Name","batchnorm3")
    leakyReluLayer(0.1,"Name","leakyrelu3")
    convolution2dLayer([3 3],64,"Name","conv4","Padding","same")
    batchNormalizationLayer("Name","batchnorm4")
    leakyReluLayer(0.1,"Name","leakyrelu4")];
net = addLayers(net,tempNet);

tempNet = [
    additionLayer(2,"Name","res1")
    convolution2dLayer([3 3],128,"Name","conv5","Padding",[1 0 1 0],"Stride",[2 2])
    batchNormalizationLayer("Name","batchnorm5")
    leakyReluLayer(0.1,"Name","leakyrelu5")];
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],64,"Name","conv6","Padding","same")
    batchNormalizationLayer("Name","batchnorm6")
    leakyReluLayer(0.1,"Name","leakyrelu6")
    convolution2dLayer([3 3],128,"Name","conv7","Padding","same")
    batchNormalizationLayer("Name","batchnorm7")
    leakyReluLayer(0.1,"Name","leakyrelu7")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res2");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],64,"Name","conv8","Padding","same")
    batchNormalizationLayer("Name","batchnorm8")
    leakyReluLayer(0.1,"Name","leakyrelu8")
    convolution2dLayer([3 3],128,"Name","conv9","Padding","same")
    batchNormalizationLayer("Name","batchnorm9")
    leakyReluLayer(0.1,"Name","leakyrelu9")];
net = addLayers(net,tempNet);

tempNet = [
    additionLayer(2,"Name","res3")
    convolution2dLayer([3 3],256,"Name","conv10","Padding",[1 0 1 0],"Stride",[2 2])
    batchNormalizationLayer("Name","batchnorm10")
    leakyReluLayer(0.1,"Name","leakyrelu10")];
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv11","Padding","same")
    batchNormalizationLayer("Name","batchnorm11")
    leakyReluLayer(0.1,"Name","leakyrelu11")
    convolution2dLayer([3 3],256,"Name","conv12","Padding","same")
    batchNormalizationLayer("Name","batchnorm12")
    leakyReluLayer(0.1,"Name","leakyrelu12")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res4");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv13","Padding","same")
    batchNormalizationLayer("Name","batchnorm13")
    leakyReluLayer(0.1,"Name","leakyrelu13")
    convolution2dLayer([3 3],256,"Name","conv14","Padding","same")
    batchNormalizationLayer("Name","batchnorm14")
    leakyReluLayer(0.1,"Name","leakyrelu14")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res5");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv15","Padding","same")
    batchNormalizationLayer("Name","batchnorm15")
    leakyReluLayer(0.1,"Name","leakyrelu15")
    convolution2dLayer([3 3],256,"Name","conv16","Padding","same")
    batchNormalizationLayer("Name","batchnorm16")
    leakyReluLayer(0.1,"Name","leakyrelu16")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res6");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv17","Padding","same")
    batchNormalizationLayer("Name","batchnorm17")
    leakyReluLayer(0.1,"Name","leakyrelu17")
    convolution2dLayer([3 3],256,"Name","conv18","Padding","same")
    batchNormalizationLayer("Name","batchnorm18")
    leakyReluLayer(0.1,"Name","leakyrelu18")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res7");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv19","Padding","same")
    batchNormalizationLayer("Name","batchnorm19")
    leakyReluLayer(0.1,"Name","leakyrelu19")
    convolution2dLayer([3 3],256,"Name","conv20","Padding","same")
    batchNormalizationLayer("Name","batchnorm20")
    leakyReluLayer(0.1,"Name","leakyrelu20")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res8");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv21","Padding","same")
    batchNormalizationLayer("Name","batchnorm21")
    leakyReluLayer(0.1,"Name","leakyrelu21")
    convolution2dLayer([3 3],256,"Name","conv22","Padding","same")
    batchNormalizationLayer("Name","batchnorm22")
    leakyReluLayer(0.1,"Name","leakyrelu22")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res9");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv23","Padding","same")
    batchNormalizationLayer("Name","batchnorm23")
    leakyReluLayer(0.1,"Name","leakyrelu23")
    convolution2dLayer([3 3],256,"Name","conv24","Padding","same")
    batchNormalizationLayer("Name","batchnorm24")
    leakyReluLayer(0.1,"Name","leakyrelu24")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res10");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],128,"Name","conv25","Padding","same")
    batchNormalizationLayer("Name","batchnorm25")
    leakyReluLayer(0.1,"Name","leakyrelu25")
    convolution2dLayer([3 3],256,"Name","conv26","Padding","same")
    batchNormalizationLayer("Name","batchnorm26")
    leakyReluLayer(0.1,"Name","leakyrelu26")];
net = addLayers(net,tempNet);

tempNet = [
    additionLayer(2,"Name","res11")
    convolution2dLayer([3 3],512,"Name","conv27","Padding",[1 0 1 0],"Stride",[2 2])
    batchNormalizationLayer("Name","batchnorm27")
    leakyReluLayer(0.1,"Name","leakyrelu27")];
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv28","Padding","same")
    batchNormalizationLayer("Name","batchnorm28")
    leakyReluLayer(0.1,"Name","leakyrelu28")
    convolution2dLayer([3 3],512,"Name","conv29","Padding","same")
    batchNormalizationLayer("Name","batchnorm29")
    leakyReluLayer(0.1,"Name","leakyrelu29")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res12");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv30","Padding","same")
    batchNormalizationLayer("Name","batchnorm30")
    leakyReluLayer(0.1,"Name","leakyrelu30")
    convolution2dLayer([3 3],512,"Name","conv31","Padding","same")
    batchNormalizationLayer("Name","batchnorm31")
    leakyReluLayer(0.1,"Name","leakyrelu31")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res13");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv32","Padding","same")
    batchNormalizationLayer("Name","batchnorm32")
    leakyReluLayer(0.1,"Name","leakyrelu32")
    convolution2dLayer([3 3],512,"Name","conv33","Padding","same")
    batchNormalizationLayer("Name","batchnorm33")
    leakyReluLayer(0.1,"Name","leakyrelu33")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res14");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv34","Padding","same")
    batchNormalizationLayer("Name","batchnorm34")
    leakyReluLayer(0.1,"Name","leakyrelu34")
    convolution2dLayer([3 3],512,"Name","conv35","Padding","same")
    batchNormalizationLayer("Name","batchnorm35")
    leakyReluLayer(0.1,"Name","leakyrelu35")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res15");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv36","Padding","same")
    batchNormalizationLayer("Name","batchnorm36")
    leakyReluLayer(0.1,"Name","leakyrelu36")
    convolution2dLayer([3 3],512,"Name","conv37","Padding","same")
    batchNormalizationLayer("Name","batchnorm37")
    leakyReluLayer(0.1,"Name","leakyrelu37")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res16");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv38","Padding","same")
    batchNormalizationLayer("Name","batchnorm38")
    leakyReluLayer(0.1,"Name","leakyrelu38")
    convolution2dLayer([3 3],512,"Name","conv39","Padding","same")
    batchNormalizationLayer("Name","batchnorm39")
    leakyReluLayer(0.1,"Name","leakyrelu39")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res17");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv40","Padding","same")
    batchNormalizationLayer("Name","batchnorm40")
    leakyReluLayer(0.1,"Name","leakyrelu40")
    convolution2dLayer([3 3],512,"Name","conv41","Padding","same")
    batchNormalizationLayer("Name","batchnorm41")
    leakyReluLayer(0.1,"Name","leakyrelu41")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res18");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],256,"Name","conv42","Padding","same")
    batchNormalizationLayer("Name","batchnorm42")
    leakyReluLayer(0.1,"Name","leakyrelu42")
    convolution2dLayer([3 3],512,"Name","conv43","Padding","same")
    batchNormalizationLayer("Name","batchnorm43")
    leakyReluLayer(0.1,"Name","leakyrelu43")];
net = addLayers(net,tempNet);

tempNet = [
    additionLayer(2,"Name","res19")
    convolution2dLayer([3 3],1024,"Name","conv44","Padding",[1 0 1 0],"Stride",[2 2])
    batchNormalizationLayer("Name","batchnorm44")
    leakyReluLayer(0.1,"Name","leakyrelu44")];
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],512,"Name","conv45","Padding","same")
    batchNormalizationLayer("Name","batchnorm45")
    leakyReluLayer(0.1,"Name","leakyrelu45")
    convolution2dLayer([3 3],1024,"Name","conv46","Padding","same")
    batchNormalizationLayer("Name","batchnorm46")
    leakyReluLayer(0.1,"Name","leakyrelu46")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res20");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],512,"Name","conv47","Padding","same")
    batchNormalizationLayer("Name","batchnorm47")
    leakyReluLayer(0.1,"Name","leakyrelu47")
    convolution2dLayer([3 3],1024,"Name","conv48","Padding","same")
    batchNormalizationLayer("Name","batchnorm48")
    leakyReluLayer(0.1,"Name","leakyrelu48")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res21");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],512,"Name","conv49","Padding","same")
    batchNormalizationLayer("Name","batchnorm49")
    leakyReluLayer(0.1,"Name","leakyrelu49")
    convolution2dLayer([3 3],1024,"Name","conv50","Padding","same")
    batchNormalizationLayer("Name","batchnorm50")
    leakyReluLayer(0.1,"Name","leakyrelu50")];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","res22");
net = addLayers(net,tempNet);

tempNet = [
    convolution2dLayer([1 1],512,"Name","conv51","Padding","same")
    batchNormalizationLayer("Name","batchnorm51")
    leakyReluLayer(0.1,"Name","leakyrelu51")
    convolution2dLayer([3 3],1024,"Name","conv52","Padding","same")
    batchNormalizationLayer("Name","batchnorm52")
    leakyReluLayer(0.1,"Name","leakyrelu52")];
net = addLayers(net,tempNet);

tempNet = [
    additionLayer(2,"Name","res23")
    globalAveragePooling2dLayer("Name","avg1")
    convolution2dLayer([1 1],numOfClasses,"Name","conv53","Padding","same")
    softmaxLayer("Name","softmax")
    flattenLayer("Name","softmax_flatten")];
net = addLayers(net,tempNet);

% clean up helper variable
clear tempNet;

net = connectLayers(net,"leakyrelu2","conv3");
net = connectLayers(net,"leakyrelu2","res1/in2");
net = connectLayers(net,"leakyrelu4","res1/in1");
net = connectLayers(net,"leakyrelu5","conv6");
net = connectLayers(net,"leakyrelu5","res2/in2");
net = connectLayers(net,"leakyrelu7","res2/in1");
net = connectLayers(net,"res2","conv8");
net = connectLayers(net,"res2","res3/in2");
net = connectLayers(net,"leakyrelu9","res3/in1");
net = connectLayers(net,"leakyrelu10","conv11");
net = connectLayers(net,"leakyrelu10","res4/in2");
net = connectLayers(net,"leakyrelu12","res4/in1");
net = connectLayers(net,"res4","conv13");
net = connectLayers(net,"res4","res5/in2");
net = connectLayers(net,"leakyrelu14","res5/in1");
net = connectLayers(net,"res5","conv15");
net = connectLayers(net,"res5","res6/in2");
net = connectLayers(net,"leakyrelu16","res6/in1");
net = connectLayers(net,"res6","conv17");
net = connectLayers(net,"res6","res7/in2");
net = connectLayers(net,"leakyrelu18","res7/in1");
net = connectLayers(net,"res7","conv19");
net = connectLayers(net,"res7","res8/in2");
net = connectLayers(net,"leakyrelu20","res8/in1");
net = connectLayers(net,"res8","conv21");
net = connectLayers(net,"res8","res9/in2");
net = connectLayers(net,"leakyrelu22","res9/in1");
net = connectLayers(net,"res9","conv23");
net = connectLayers(net,"res9","res10/in2");
net = connectLayers(net,"leakyrelu24","res10/in1");
net = connectLayers(net,"res10","conv25");
net = connectLayers(net,"res10","res11/in2");
net = connectLayers(net,"leakyrelu26","res11/in1");
net = connectLayers(net,"leakyrelu27","conv28");
net = connectLayers(net,"leakyrelu27","res12/in2");
net = connectLayers(net,"leakyrelu29","res12/in1");
net = connectLayers(net,"res12","conv30");
net = connectLayers(net,"res12","res13/in2");
net = connectLayers(net,"leakyrelu31","res13/in1");
net = connectLayers(net,"res13","conv32");
net = connectLayers(net,"res13","res14/in2");
net = connectLayers(net,"leakyrelu33","res14/in1");
net = connectLayers(net,"res14","conv34");
net = connectLayers(net,"res14","res15/in2");
net = connectLayers(net,"leakyrelu35","res15/in1");
net = connectLayers(net,"res15","conv36");
net = connectLayers(net,"res15","res16/in2");
net = connectLayers(net,"leakyrelu37","res16/in1");
net = connectLayers(net,"res16","conv38");
net = connectLayers(net,"res16","res17/in2");
net = connectLayers(net,"leakyrelu39","res17/in1");
net = connectLayers(net,"res17","conv40");
net = connectLayers(net,"res17","res18/in2");
net = connectLayers(net,"leakyrelu41","res18/in1");
net = connectLayers(net,"res18","conv42");
net = connectLayers(net,"res18","res19/in2");
net = connectLayers(net,"leakyrelu43","res19/in1");
net = connectLayers(net,"leakyrelu44","conv45");
net = connectLayers(net,"leakyrelu44","res20/in2");
net = connectLayers(net,"leakyrelu46","res20/in1");
net = connectLayers(net,"res20","conv47");
net = connectLayers(net,"res20","res21/in2");
net = connectLayers(net,"leakyrelu48","res21/in1");
net = connectLayers(net,"res21","conv49");
net = connectLayers(net,"res21","res22/in2");
net = connectLayers(net,"leakyrelu50","res22/in1");
net = connectLayers(net,"res22","conv51");
net = connectLayers(net,"res22","res23/in2");
net = connectLayers(net,"leakyrelu52","res23/in1");
net = initialize(net);
end