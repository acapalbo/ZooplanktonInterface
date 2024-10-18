function net = setupNetworkNasNetLarge(inputSize,numOfClasses)
net = dlnetwork;
tempNet = [
    imageInputLayer(inputSize,"Name","input_2","Normalization","rescale-symmetric")
    convolution2dLayer([3 3],96,"Name","stem_conv1","BiasLearnRateFactor",0,"Stride",[2 2])
    batchNormalizationLayer("Name","stem_bn1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_261")
    convolution2dLayer([1 1],42,"Name","reduction_conv_1_stem_1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","reduction_bn_1_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_262")
    groupedConvolution2dLayer([5 5],1,42,"Name","separable_conv_1_reduction_left1_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","separable_conv_1_reduction_left1_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left1_stem_1","Epsilon",0.001)
    reluLayer("Name","activation_263")
    groupedConvolution2dLayer([5 5],1,42,"Name","separable_conv_2_reduction_left1_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_2_reduction_left1_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left1_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_264")
    groupedConvolution2dLayer([7 7],1,96,"Name","separable_conv_1_reduction_right1_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","separable_conv_1_reduction_right1_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right1_stem_1","Epsilon",0.001)
    reluLayer("Name","activation_265")
    groupedConvolution2dLayer([7 7],1,42,"Name","separable_conv_2_reduction_right1_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_2_reduction_right1_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right1_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_266")
    groupedConvolution2dLayer([7 7],1,96,"Name","separable_conv_1_reduction_right2_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","separable_conv_1_reduction_right2_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right2_stem_1","Epsilon",0.001)
    reluLayer("Name","activation_267")
    groupedConvolution2dLayer([7 7],1,42,"Name","separable_conv_2_reduction_right2_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_2_reduction_right2_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right2_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_1_stem_1");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_268")
    groupedConvolution2dLayer([5 5],1,96,"Name","separable_conv_1_reduction_right3_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","separable_conv_1_reduction_right3_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right3_stem_1","Epsilon",0.001)
    reluLayer("Name","activation_269")
    groupedConvolution2dLayer([5 5],1,42,"Name","separable_conv_2_reduction_right3_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_2_reduction_right3_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right3_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_270")
    groupedConvolution2dLayer([3 3],1,42,"Name","separable_conv_1_reduction_left4_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_1_reduction_left4_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left4_stem_1","Epsilon",0.001)
    reluLayer("Name","activation_271")
    groupedConvolution2dLayer([3 3],1,42,"Name","separable_conv_2_reduction_left4_stem_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],42,"Name","separable_conv_2_reduction_left4_stem_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left4_stem_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_left2_stem_1","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = reluLayer("Name","adjust_relu_1_stem_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_2_stem_1");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left3_stem_1","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left4_stem_1","Padding","same");
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_right5_stem_1","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = helperNnetNasnetlargeLayerNASNetLargeZeroPadding2dLayer("zero_padding2d_5",0,1,0,1,"in","out");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add3_stem_1");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","add_5");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add4_stem_1");
net = addLayers(net,tempNet);

tempNet = [
    crop2dLayer([2 2],"Name","cropping2d_5")
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_2_stem_2","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","adjust_conv_2_stem_2","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(4,"Name","reduction_concat_stem_1");
net = addLayers(net,tempNet);

tempNet = [
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_1_stem_2","Stride",[2 2])
    convolution2dLayer([1 1],42,"Name","adjust_conv_1_stem_2","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_272")
    convolution2dLayer([1 1],84,"Name","reduction_conv_1_stem_2","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","reduction_bn_1_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(2,"Name","concatenate_5")
    batchNormalizationLayer("Name","adjust_bn_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_273")
    groupedConvolution2dLayer([5 5],1,84,"Name","separable_conv_1_reduction_left1_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","separable_conv_1_reduction_left1_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left1_stem_2","Epsilon",0.001)
    reluLayer("Name","activation_274")
    groupedConvolution2dLayer([5 5],1,84,"Name","separable_conv_2_reduction_left1_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_2_reduction_left1_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left1_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_275")
    groupedConvolution2dLayer([7 7],1,84,"Name","separable_conv_1_reduction_right1_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","separable_conv_1_reduction_right1_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right1_stem_2","Epsilon",0.001)
    reluLayer("Name","activation_276")
    groupedConvolution2dLayer([7 7],1,84,"Name","separable_conv_2_reduction_right1_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_2_reduction_right1_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right1_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_277")
    groupedConvolution2dLayer([7 7],1,84,"Name","separable_conv_1_reduction_right2_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","separable_conv_1_reduction_right2_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right2_stem_2","Epsilon",0.001)
    reluLayer("Name","activation_278")
    groupedConvolution2dLayer([7 7],1,84,"Name","separable_conv_2_reduction_right2_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_2_reduction_right2_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right2_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_1_stem_2");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_279")
    groupedConvolution2dLayer([5 5],1,84,"Name","separable_conv_1_reduction_right3_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","separable_conv_1_reduction_right3_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right3_stem_2","Epsilon",0.001)
    reluLayer("Name","activation_280")
    groupedConvolution2dLayer([5 5],1,84,"Name","separable_conv_2_reduction_right3_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_2_reduction_right3_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right3_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_281")
    groupedConvolution2dLayer([3 3],1,84,"Name","separable_conv_1_reduction_left4_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_1_reduction_left4_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left4_stem_2","Epsilon",0.001)
    reluLayer("Name","activation_282")
    groupedConvolution2dLayer([3 3],1,84,"Name","separable_conv_2_reduction_left4_stem_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],84,"Name","separable_conv_2_reduction_left4_stem_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left4_stem_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_left2_stem_2","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = reluLayer("Name","adjust_relu_1_0");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_2_stem_2");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left3_stem_2","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left4_stem_2","Padding","same");
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_right5_stem_2","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = helperNnetNasnetlargeLayerNASNetLargeZeroPadding2dLayer("zero_padding2d_6",0,1,0,1,"in","out");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add3_stem_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","add_6");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add4_stem_2");
net = addLayers(net,tempNet);

tempNet = [
    crop2dLayer([2 2],"Name","cropping2d_6")
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_2_0","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","adjust_conv_2_0","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(4,"Name","reduction_concat_stem_2");
net = addLayers(net,tempNet);

tempNet = [
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_1_0","Stride",[2 2])
    convolution2dLayer([1 1],84,"Name","adjust_conv_1_0","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_283")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_0","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(2,"Name","concatenate_6")
    batchNormalizationLayer("Name","adjust_bn_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_284")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_0","Epsilon",0.001)
    reluLayer("Name","activation_285")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_286")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_0","Epsilon",0.001)
    reluLayer("Name","activation_287")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_288")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_0","Epsilon",0.001)
    reluLayer("Name","activation_289")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_290")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_0","Epsilon",0.001)
    reluLayer("Name","activation_291")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_292")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_0","Epsilon",0.001)
    reluLayer("Name","activation_293")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_0_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_0_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_0","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_0","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_0","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_0","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_0");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_0");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_0");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_0");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_0");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_0");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_294")
    convolution2dLayer([1 1],168,"Name","adjust_conv_projection_1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_295")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_1","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_296")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_1","Epsilon",0.001)
    reluLayer("Name","activation_297")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_298")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_1","Epsilon",0.001)
    reluLayer("Name","activation_299")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_300")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_1","Epsilon",0.001)
    reluLayer("Name","activation_301")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_302")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_1","Epsilon",0.001)
    reluLayer("Name","activation_303")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_304")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_1","Epsilon",0.001)
    reluLayer("Name","activation_305")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_1_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_1_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_1","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_1","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_1","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_1","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_1");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_1");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_1");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_1");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_1");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_1");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_306")
    convolution2dLayer([1 1],168,"Name","adjust_conv_projection_2","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_307")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_2","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_308")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_2","Epsilon",0.001)
    reluLayer("Name","activation_309")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_310")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_2","Epsilon",0.001)
    reluLayer("Name","activation_311")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_312")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_2","Epsilon",0.001)
    reluLayer("Name","activation_313")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_314")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_2","Epsilon",0.001)
    reluLayer("Name","activation_315")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_316")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_2","Epsilon",0.001)
    reluLayer("Name","activation_317")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_2_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_2_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_2","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_2","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_2","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_2","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_2");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_2");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_2");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_318")
    convolution2dLayer([1 1],168,"Name","adjust_conv_projection_3","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_319")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_3","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_320")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_3","Epsilon",0.001)
    reluLayer("Name","activation_321")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_322")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_3","Epsilon",0.001)
    reluLayer("Name","activation_323")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_324")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_3","Epsilon",0.001)
    reluLayer("Name","activation_325")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_326")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_3","Epsilon",0.001)
    reluLayer("Name","activation_327")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_328")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_3","Epsilon",0.001)
    reluLayer("Name","activation_329")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_3_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_3_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_3","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_3","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_3","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_3","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_3");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_3");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_3");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_3");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_3");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_3");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_330")
    convolution2dLayer([1 1],168,"Name","adjust_conv_projection_4","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_331")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_4","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_332")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_4","Epsilon",0.001)
    reluLayer("Name","activation_333")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_334")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_4","Epsilon",0.001)
    reluLayer("Name","activation_335")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_336")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_4","Epsilon",0.001)
    reluLayer("Name","activation_337")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_338")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_4","Epsilon",0.001)
    reluLayer("Name","activation_339")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_340")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_4","Epsilon",0.001)
    reluLayer("Name","activation_341")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_4_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_4_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_4","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_4","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_4","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_4","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_4");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_4");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_4");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_4");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_4");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_4");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_342")
    convolution2dLayer([1 1],168,"Name","adjust_conv_projection_5","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_343")
    convolution2dLayer([1 1],168,"Name","normal_conv_1_5","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_344")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left1_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left1_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_5","Epsilon",0.001)
    reluLayer("Name","activation_345")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left1_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left1_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_346")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right1_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right1_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_5","Epsilon",0.001)
    reluLayer("Name","activation_347")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right1_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right1_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_348")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_1_normal_left2_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left2_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_5","Epsilon",0.001)
    reluLayer("Name","activation_349")
    groupedConvolution2dLayer([5 5],1,168,"Name","separable_conv_2_normal_left2_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left2_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_350")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_right2_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_right2_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_5","Epsilon",0.001)
    reluLayer("Name","activation_351")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_right2_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_right2_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_352")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_1_normal_left5_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_1_normal_left5_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_5","Epsilon",0.001)
    reluLayer("Name","activation_353")
    groupedConvolution2dLayer([3 3],1,168,"Name","separable_conv_2_normal_left5_5_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],168,"Name","separable_conv_2_normal_left5_5_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_5","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_5","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_5","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_5","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_5");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_5");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_5");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_5");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_5");
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(6,"Name","normal_concat_5")
    reluLayer("Name","activation_355")
    convolution2dLayer([1 1],336,"Name","reduction_conv_1_reduce_6","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","reduction_bn_1_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_354")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_reduce_6","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_356")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_reduction_left1_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","separable_conv_1_reduction_left1_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left1_reduce_6","Epsilon",0.001)
    reluLayer("Name","activation_357")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_reduction_left1_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_reduction_left1_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left1_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_358")
    groupedConvolution2dLayer([7 7],1,336,"Name","separable_conv_1_reduction_right1_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","separable_conv_1_reduction_right1_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right1_reduce_6","Epsilon",0.001)
    reluLayer("Name","activation_359")
    groupedConvolution2dLayer([7 7],1,336,"Name","separable_conv_2_reduction_right1_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_reduction_right1_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right1_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_360")
    groupedConvolution2dLayer([7 7],1,336,"Name","separable_conv_1_reduction_right2_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","separable_conv_1_reduction_right2_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right2_reduce_6","Epsilon",0.001)
    reluLayer("Name","activation_361")
    groupedConvolution2dLayer([7 7],1,336,"Name","separable_conv_2_reduction_right2_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_reduction_right2_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right2_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_1_reduce_6");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_362")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_reduction_right3_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","separable_conv_1_reduction_right3_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right3_reduce_6","Epsilon",0.001)
    reluLayer("Name","activation_363")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_reduction_right3_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_reduction_right3_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right3_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_364")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_reduction_left4_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_reduction_left4_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left4_reduce_6","Epsilon",0.001)
    reluLayer("Name","activation_365")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_reduction_left4_reduce_6_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_reduction_left4_reduce_6_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left4_reduce_6","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_left2_reduce_6","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = reluLayer("Name","adjust_relu_1_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_2_reduce_6");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left3_reduce_6","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left4_reduce_6","Padding","same");
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_right5_reduce_6","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = helperNnetNasnetlargeLayerNASNetLargeZeroPadding2dLayer("zero_padding2d_7",0,1,0,1,"in","out");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add3_reduce_6");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","add_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add4_reduce_6");
net = addLayers(net,tempNet);

tempNet = [
    crop2dLayer([2 2],"Name","cropping2d_7")
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_2_7","Stride",[2 2])
    convolution2dLayer([1 1],168,"Name","adjust_conv_2_7","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(4,"Name","reduction_concat_reduce_6");
net = addLayers(net,tempNet);

tempNet = [
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_1_7","Stride",[2 2])
    convolution2dLayer([1 1],168,"Name","adjust_conv_1_7","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_366")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_7","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(2,"Name","concatenate_7")
    batchNormalizationLayer("Name","adjust_bn_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_367")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_7","Epsilon",0.001)
    reluLayer("Name","activation_368")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_369")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_7","Epsilon",0.001)
    reluLayer("Name","activation_370")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_371")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_7","Epsilon",0.001)
    reluLayer("Name","activation_372")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_373")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_7","Epsilon",0.001)
    reluLayer("Name","activation_374")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_375")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_7","Epsilon",0.001)
    reluLayer("Name","activation_376")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_7_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_7_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_7","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_7","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_7","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_7","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_7");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_7");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_7");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_377")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_8","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_378")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_8","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_379")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_8","Epsilon",0.001)
    reluLayer("Name","activation_380")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_381")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_8","Epsilon",0.001)
    reluLayer("Name","activation_382")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_383")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_8","Epsilon",0.001)
    reluLayer("Name","activation_384")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_385")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_8","Epsilon",0.001)
    reluLayer("Name","activation_386")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_387")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_8","Epsilon",0.001)
    reluLayer("Name","activation_388")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_8_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_8_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_8","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_8","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_8","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_8","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_8");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_8");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_8");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_8");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_8");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_8");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_389")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_9","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_390")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_9","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_391")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_9","Epsilon",0.001)
    reluLayer("Name","activation_392")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_393")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_9","Epsilon",0.001)
    reluLayer("Name","activation_394")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_395")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_9","Epsilon",0.001)
    reluLayer("Name","activation_396")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_397")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_9","Epsilon",0.001)
    reluLayer("Name","activation_398")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_399")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_9","Epsilon",0.001)
    reluLayer("Name","activation_400")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_9_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_9_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_9","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_9","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_9","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_9","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_9");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_9");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_9");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_9");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_9");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_9");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_401")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_10","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_402")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_10","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_403")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_10","Epsilon",0.001)
    reluLayer("Name","activation_404")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_405")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_10","Epsilon",0.001)
    reluLayer("Name","activation_406")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_407")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_10","Epsilon",0.001)
    reluLayer("Name","activation_408")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_409")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_10","Epsilon",0.001)
    reluLayer("Name","activation_410")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_411")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_10","Epsilon",0.001)
    reluLayer("Name","activation_412")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_10_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_10_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_10","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_10","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_10","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_10","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_10");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_10");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_10");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_10");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_10");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_10");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_413")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_11","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_414")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_11","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_415")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_11","Epsilon",0.001)
    reluLayer("Name","activation_416")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_417")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_11","Epsilon",0.001)
    reluLayer("Name","activation_418")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_419")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_11","Epsilon",0.001)
    reluLayer("Name","activation_420")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_421")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_11","Epsilon",0.001)
    reluLayer("Name","activation_422")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_423")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_11","Epsilon",0.001)
    reluLayer("Name","activation_424")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_11_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_11_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_11","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_11","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_11","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_11","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_11");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_11");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_11");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_11");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_11");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_11");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_425")
    convolution2dLayer([1 1],336,"Name","adjust_conv_projection_12","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_426")
    convolution2dLayer([1 1],336,"Name","normal_conv_1_12","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_427")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left1_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left1_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_12","Epsilon",0.001)
    reluLayer("Name","activation_428")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left1_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left1_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_429")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right1_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right1_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_12","Epsilon",0.001)
    reluLayer("Name","activation_430")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right1_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right1_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_431")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_1_normal_left2_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left2_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_12","Epsilon",0.001)
    reluLayer("Name","activation_432")
    groupedConvolution2dLayer([5 5],1,336,"Name","separable_conv_2_normal_left2_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left2_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_433")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_right2_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_right2_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_12","Epsilon",0.001)
    reluLayer("Name","activation_434")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_right2_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_right2_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_435")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_1_normal_left5_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_1_normal_left5_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_12","Epsilon",0.001)
    reluLayer("Name","activation_436")
    groupedConvolution2dLayer([3 3],1,336,"Name","separable_conv_2_normal_left5_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],336,"Name","separable_conv_2_normal_left5_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_12","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_12","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_12","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_12");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_12");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_12");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_12");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_12");
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(6,"Name","normal_concat_12")
    reluLayer("Name","activation_438")
    convolution2dLayer([1 1],672,"Name","reduction_conv_1_reduce_12","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","reduction_bn_1_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_437")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_reduce_12","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_439")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_reduction_left1_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],672,"Name","separable_conv_1_reduction_left1_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left1_reduce_12","Epsilon",0.001)
    reluLayer("Name","activation_440")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_reduction_left1_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_reduction_left1_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left1_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_441")
    groupedConvolution2dLayer([7 7],1,672,"Name","separable_conv_1_reduction_right1_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],672,"Name","separable_conv_1_reduction_right1_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right1_reduce_12","Epsilon",0.001)
    reluLayer("Name","activation_442")
    groupedConvolution2dLayer([7 7],1,672,"Name","separable_conv_2_reduction_right1_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_reduction_right1_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right1_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_443")
    groupedConvolution2dLayer([7 7],1,672,"Name","separable_conv_1_reduction_right2_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],672,"Name","separable_conv_1_reduction_right2_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right2_reduce_12","Epsilon",0.001)
    reluLayer("Name","activation_444")
    groupedConvolution2dLayer([7 7],1,672,"Name","separable_conv_2_reduction_right2_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_reduction_right2_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right2_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_1_reduce_12");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_445")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_reduction_right3_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2])
    convolution2dLayer([1 1],672,"Name","separable_conv_1_reduction_right3_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_right3_reduce_12","Epsilon",0.001)
    reluLayer("Name","activation_446")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_reduction_right3_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_reduction_right3_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_right3_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_447")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_reduction_left4_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_reduction_left4_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_reduction_left4_reduce_12","Epsilon",0.001)
    reluLayer("Name","activation_448")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_reduction_left4_reduce_12_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_reduction_left4_reduce_12_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_reduction_left4_reduce_12","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_left2_reduce_12","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = reluLayer("Name","adjust_relu_1_13");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add_2_reduce_12");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left3_reduce_12","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","reduction_left4_reduce_12","Padding","same");
net = addLayers(net,tempNet);

tempNet = maxPooling2dLayer([3 3],"Name","reduction_right5_reduce_12","Padding","same","Stride",[2 2]);
net = addLayers(net,tempNet);

tempNet = helperNnetNasnetlargeLayerNASNetLargeZeroPadding2dLayer("zero_padding2d_8",0,1,0,1,"in","out");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add3_reduce_12");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","add_8");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","reduction_add4_reduce_12");
net = addLayers(net,tempNet);

tempNet = [
    crop2dLayer([2 2],"Name","cropping2d_8")
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_2_13","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","adjust_conv_2_13","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(4,"Name","reduction_concat_reduce_12");
net = addLayers(net,tempNet);

tempNet = [
    averagePooling2dLayer([1 1],"Name","adjust_avg_pool_1_13","Stride",[2 2])
    convolution2dLayer([1 1],336,"Name","adjust_conv_1_13","BiasLearnRateFactor",0,"Padding","same")];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_449")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_13","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(2,"Name","concatenate_8")
    batchNormalizationLayer("Name","adjust_bn_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_450")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_13","Epsilon",0.001)
    reluLayer("Name","activation_451")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_452")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_13","Epsilon",0.001)
    reluLayer("Name","activation_453")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_454")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_13","Epsilon",0.001)
    reluLayer("Name","activation_455")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_456")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_13","Epsilon",0.001)
    reluLayer("Name","activation_457")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_458")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_13","Epsilon",0.001)
    reluLayer("Name","activation_459")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_13_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_13_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_13","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_13","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_13","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_13","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_13");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_13");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_13");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_13");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_13");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_13");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_460")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_14","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_461")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_14","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_462")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_14","Epsilon",0.001)
    reluLayer("Name","activation_463")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_464")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_14","Epsilon",0.001)
    reluLayer("Name","activation_465")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_466")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_14","Epsilon",0.001)
    reluLayer("Name","activation_467")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_468")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_14","Epsilon",0.001)
    reluLayer("Name","activation_469")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_470")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_14","Epsilon",0.001)
    reluLayer("Name","activation_471")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_14_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_14_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_14","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_14","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_14","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_14","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_14");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_14");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_14");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_14");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_14");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_14");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_472")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_15","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_473")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_15","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_474")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_15","Epsilon",0.001)
    reluLayer("Name","activation_475")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_476")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_15","Epsilon",0.001)
    reluLayer("Name","activation_477")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_478")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_15","Epsilon",0.001)
    reluLayer("Name","activation_479")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_480")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_15","Epsilon",0.001)
    reluLayer("Name","activation_481")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_482")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_15","Epsilon",0.001)
    reluLayer("Name","activation_483")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_15_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_15_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_15","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_15","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_15","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_15","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_15");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_15");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_15");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_15");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_15");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_15");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_484")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_16","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_485")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_16","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_486")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_16","Epsilon",0.001)
    reluLayer("Name","activation_487")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_488")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_16","Epsilon",0.001)
    reluLayer("Name","activation_489")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_490")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_16","Epsilon",0.001)
    reluLayer("Name","activation_491")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_492")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_16","Epsilon",0.001)
    reluLayer("Name","activation_493")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_494")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_16","Epsilon",0.001)
    reluLayer("Name","activation_495")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_16_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_16_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_16","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_16","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_16","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_16","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_16");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_16");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_16");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_16");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_16");
net = addLayers(net,tempNet);

tempNet = depthConcatenationLayer(6,"Name","normal_concat_16");
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_496")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_17","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_497")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_17","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_498")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_17","Epsilon",0.001)
    reluLayer("Name","activation_499")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_500")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_17","Epsilon",0.001)
    reluLayer("Name","activation_501")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_502")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_17","Epsilon",0.001)
    reluLayer("Name","activation_503")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_504")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_17","Epsilon",0.001)
    reluLayer("Name","activation_505")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_506")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_17","Epsilon",0.001)
    reluLayer("Name","activation_507")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_17_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_17_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_17","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_17","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_17","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_17","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_17");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_17");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_17");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_17");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_17");
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(6,"Name","normal_concat_17")
    reluLayer("Name","activation_509")
    convolution2dLayer([1 1],672,"Name","normal_conv_1_18","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","normal_bn_1_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_508")
    convolution2dLayer([1 1],672,"Name","adjust_conv_projection_18","BiasLearnRateFactor",0,"Padding","same")
    batchNormalizationLayer("Name","adjust_bn_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_510")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left1_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left1_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left1_18","Epsilon",0.001)
    reluLayer("Name","activation_511")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left1_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left1_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left1_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_512")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right1_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right1_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right1_18","Epsilon",0.001)
    reluLayer("Name","activation_513")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right1_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right1_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right1_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_514")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_1_normal_left2_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left2_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left2_18","Epsilon",0.001)
    reluLayer("Name","activation_515")
    groupedConvolution2dLayer([5 5],1,672,"Name","separable_conv_2_normal_left2_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left2_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left2_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_516")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_right2_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_right2_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_right2_18","Epsilon",0.001)
    reluLayer("Name","activation_517")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_right2_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_right2_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_right2_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = [
    reluLayer("Name","activation_518")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_1_normal_left5_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_1_normal_left5_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_1_bn_normal_left5_18","Epsilon",0.001)
    reluLayer("Name","activation_519")
    groupedConvolution2dLayer([3 3],1,672,"Name","separable_conv_2_normal_left5_18_channel-wise","BiasLearnRateFactor",0,"Padding","same")
    convolution2dLayer([1 1],672,"Name","separable_conv_2_normal_left5_18_point-wise","BiasLearnRateFactor",0)
    batchNormalizationLayer("Name","separable_conv_2_bn_normal_left5_18","Epsilon",0.001)];
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left3_18","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_left4_18","Padding","same");
net = addLayers(net,tempNet);

tempNet = averagePooling2dLayer([3 3],"Name","normal_right4_18","Padding","same");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_1_18");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_2_18");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_3_18");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_4_18");
net = addLayers(net,tempNet);

tempNet = additionLayer(2,"Name","normal_add_5_18");
net = addLayers(net,tempNet);

tempNet = [
    depthConcatenationLayer(6,"Name","normal_concat_18")
    reluLayer("Name","activation_520")
    globalAveragePooling2dLayer("Name","global_average_pooling2d_2")
    fullyConnectedLayer(numOfClasses,"Name","predictions")
    softmaxLayer("Name","predictions_softmax")];
net = addLayers(net,tempNet);

% clean up helper variable
clear tempNet;

net = connectLayers(net,"stem_bn1","activation_261");
net = connectLayers(net,"stem_bn1","activation_264");
net = connectLayers(net,"stem_bn1","activation_266");
net = connectLayers(net,"stem_bn1","activation_268");
net = connectLayers(net,"stem_bn1","adjust_relu_1_stem_2");
net = connectLayers(net,"reduction_bn_1_stem_1","activation_262");
net = connectLayers(net,"reduction_bn_1_stem_1","reduction_left2_stem_1");
net = connectLayers(net,"reduction_bn_1_stem_1","reduction_left3_stem_1");
net = connectLayers(net,"reduction_bn_1_stem_1","reduction_right5_stem_1");
net = connectLayers(net,"separable_conv_2_bn_reduction_left1_stem_1","reduction_add_1_stem_1/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right1_stem_1","reduction_add_1_stem_1/in2");
net = connectLayers(net,"reduction_add_1_stem_1","activation_270");
net = connectLayers(net,"reduction_add_1_stem_1","reduction_left4_stem_1");
net = connectLayers(net,"reduction_left2_stem_1","reduction_add_2_stem_1/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right2_stem_1","reduction_add_2_stem_1/in2");
net = connectLayers(net,"adjust_relu_1_stem_2","zero_padding2d_5");
net = connectLayers(net,"adjust_relu_1_stem_2","cropping2d_5/ref");
net = connectLayers(net,"adjust_relu_1_stem_2","adjust_avg_pool_1_stem_2");
net = connectLayers(net,"reduction_add_2_stem_1","add_5/in1");
net = connectLayers(net,"reduction_add_2_stem_1","reduction_concat_stem_1/in1");
net = connectLayers(net,"reduction_left3_stem_1","reduction_add3_stem_1/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right3_stem_1","reduction_add3_stem_1/in2");
net = connectLayers(net,"reduction_left4_stem_1","add_5/in2");
net = connectLayers(net,"separable_conv_2_bn_reduction_left4_stem_1","reduction_add4_stem_1/in1");
net = connectLayers(net,"reduction_right5_stem_1","reduction_add4_stem_1/in2");
net = connectLayers(net,"zero_padding2d_5","cropping2d_5/in");
net = connectLayers(net,"reduction_add3_stem_1","reduction_concat_stem_1/in2");
net = connectLayers(net,"add_5","reduction_concat_stem_1/in3");
net = connectLayers(net,"reduction_add4_stem_1","reduction_concat_stem_1/in4");
net = connectLayers(net,"reduction_concat_stem_1","activation_272");
net = connectLayers(net,"reduction_concat_stem_1","adjust_relu_1_0");
net = connectLayers(net,"adjust_conv_1_stem_2","concatenate_5/in1");
net = connectLayers(net,"adjust_conv_2_stem_2","concatenate_5/in2");
net = connectLayers(net,"reduction_bn_1_stem_2","activation_273");
net = connectLayers(net,"reduction_bn_1_stem_2","reduction_left2_stem_2");
net = connectLayers(net,"reduction_bn_1_stem_2","reduction_left3_stem_2");
net = connectLayers(net,"reduction_bn_1_stem_2","reduction_right5_stem_2");
net = connectLayers(net,"adjust_bn_stem_2","activation_275");
net = connectLayers(net,"adjust_bn_stem_2","activation_277");
net = connectLayers(net,"adjust_bn_stem_2","activation_279");
net = connectLayers(net,"separable_conv_2_bn_reduction_left1_stem_2","reduction_add_1_stem_2/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right1_stem_2","reduction_add_1_stem_2/in2");
net = connectLayers(net,"reduction_add_1_stem_2","activation_281");
net = connectLayers(net,"reduction_add_1_stem_2","reduction_left4_stem_2");
net = connectLayers(net,"reduction_left2_stem_2","reduction_add_2_stem_2/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right2_stem_2","reduction_add_2_stem_2/in2");
net = connectLayers(net,"adjust_relu_1_0","zero_padding2d_6");
net = connectLayers(net,"adjust_relu_1_0","cropping2d_6/ref");
net = connectLayers(net,"adjust_relu_1_0","adjust_avg_pool_1_0");
net = connectLayers(net,"reduction_add_2_stem_2","add_6/in1");
net = connectLayers(net,"reduction_add_2_stem_2","reduction_concat_stem_2/in1");
net = connectLayers(net,"reduction_left3_stem_2","reduction_add3_stem_2/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right3_stem_2","reduction_add3_stem_2/in2");
net = connectLayers(net,"reduction_left4_stem_2","add_6/in2");
net = connectLayers(net,"separable_conv_2_bn_reduction_left4_stem_2","reduction_add4_stem_2/in1");
net = connectLayers(net,"reduction_right5_stem_2","reduction_add4_stem_2/in2");
net = connectLayers(net,"zero_padding2d_6","cropping2d_6/in");
net = connectLayers(net,"reduction_add3_stem_2","reduction_concat_stem_2/in2");
net = connectLayers(net,"add_6","reduction_concat_stem_2/in3");
net = connectLayers(net,"reduction_add4_stem_2","reduction_concat_stem_2/in4");
net = connectLayers(net,"reduction_concat_stem_2","activation_283");
net = connectLayers(net,"reduction_concat_stem_2","activation_294");
net = connectLayers(net,"adjust_conv_1_0","concatenate_6/in1");
net = connectLayers(net,"adjust_conv_2_0","concatenate_6/in2");
net = connectLayers(net,"adjust_bn_0","activation_286");
net = connectLayers(net,"adjust_bn_0","activation_288");
net = connectLayers(net,"adjust_bn_0","activation_290");
net = connectLayers(net,"adjust_bn_0","normal_left4_0");
net = connectLayers(net,"adjust_bn_0","normal_right4_0");
net = connectLayers(net,"adjust_bn_0","normal_add_3_0/in2");
net = connectLayers(net,"adjust_bn_0","normal_concat_0/in1");
net = connectLayers(net,"normal_bn_1_0","activation_284");
net = connectLayers(net,"normal_bn_1_0","activation_292");
net = connectLayers(net,"normal_bn_1_0","normal_left3_0");
net = connectLayers(net,"normal_bn_1_0","normal_add_5_0/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_0","normal_add_1_0/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_0","normal_add_1_0/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_0","normal_add_2_0/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_0","normal_add_2_0/in2");
net = connectLayers(net,"normal_left3_0","normal_add_3_0/in1");
net = connectLayers(net,"normal_left4_0","normal_add_4_0/in1");
net = connectLayers(net,"normal_right4_0","normal_add_4_0/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_0","normal_add_5_0/in1");
net = connectLayers(net,"normal_add_1_0","normal_concat_0/in2");
net = connectLayers(net,"normal_add_2_0","normal_concat_0/in3");
net = connectLayers(net,"normal_add_3_0","normal_concat_0/in4");
net = connectLayers(net,"normal_add_4_0","normal_concat_0/in5");
net = connectLayers(net,"normal_add_5_0","normal_concat_0/in6");
net = connectLayers(net,"normal_concat_0","activation_295");
net = connectLayers(net,"normal_concat_0","activation_306");
net = connectLayers(net,"adjust_bn_1","activation_298");
net = connectLayers(net,"adjust_bn_1","activation_300");
net = connectLayers(net,"adjust_bn_1","activation_302");
net = connectLayers(net,"adjust_bn_1","normal_left4_1");
net = connectLayers(net,"adjust_bn_1","normal_right4_1");
net = connectLayers(net,"adjust_bn_1","normal_add_3_1/in2");
net = connectLayers(net,"adjust_bn_1","normal_concat_1/in1");
net = connectLayers(net,"normal_bn_1_1","activation_296");
net = connectLayers(net,"normal_bn_1_1","activation_304");
net = connectLayers(net,"normal_bn_1_1","normal_left3_1");
net = connectLayers(net,"normal_bn_1_1","normal_add_5_1/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_1","normal_add_1_1/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_1","normal_add_1_1/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_1","normal_add_2_1/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_1","normal_add_2_1/in2");
net = connectLayers(net,"normal_left3_1","normal_add_3_1/in1");
net = connectLayers(net,"normal_left4_1","normal_add_4_1/in1");
net = connectLayers(net,"normal_right4_1","normal_add_4_1/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_1","normal_add_5_1/in1");
net = connectLayers(net,"normal_add_1_1","normal_concat_1/in2");
net = connectLayers(net,"normal_add_2_1","normal_concat_1/in3");
net = connectLayers(net,"normal_add_3_1","normal_concat_1/in4");
net = connectLayers(net,"normal_add_4_1","normal_concat_1/in5");
net = connectLayers(net,"normal_add_5_1","normal_concat_1/in6");
net = connectLayers(net,"normal_concat_1","activation_307");
net = connectLayers(net,"normal_concat_1","activation_318");
net = connectLayers(net,"adjust_bn_2","activation_310");
net = connectLayers(net,"adjust_bn_2","activation_312");
net = connectLayers(net,"adjust_bn_2","activation_314");
net = connectLayers(net,"adjust_bn_2","normal_left4_2");
net = connectLayers(net,"adjust_bn_2","normal_right4_2");
net = connectLayers(net,"adjust_bn_2","normal_add_3_2/in2");
net = connectLayers(net,"adjust_bn_2","normal_concat_2/in1");
net = connectLayers(net,"normal_bn_1_2","activation_308");
net = connectLayers(net,"normal_bn_1_2","activation_316");
net = connectLayers(net,"normal_bn_1_2","normal_left3_2");
net = connectLayers(net,"normal_bn_1_2","normal_add_5_2/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_2","normal_add_1_2/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_2","normal_add_1_2/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_2","normal_add_2_2/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_2","normal_add_2_2/in2");
net = connectLayers(net,"normal_left3_2","normal_add_3_2/in1");
net = connectLayers(net,"normal_left4_2","normal_add_4_2/in1");
net = connectLayers(net,"normal_right4_2","normal_add_4_2/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_2","normal_add_5_2/in1");
net = connectLayers(net,"normal_add_1_2","normal_concat_2/in2");
net = connectLayers(net,"normal_add_2_2","normal_concat_2/in3");
net = connectLayers(net,"normal_add_3_2","normal_concat_2/in4");
net = connectLayers(net,"normal_add_4_2","normal_concat_2/in5");
net = connectLayers(net,"normal_add_5_2","normal_concat_2/in6");
net = connectLayers(net,"normal_concat_2","activation_319");
net = connectLayers(net,"normal_concat_2","activation_330");
net = connectLayers(net,"adjust_bn_3","activation_322");
net = connectLayers(net,"adjust_bn_3","activation_324");
net = connectLayers(net,"adjust_bn_3","activation_326");
net = connectLayers(net,"adjust_bn_3","normal_left4_3");
net = connectLayers(net,"adjust_bn_3","normal_right4_3");
net = connectLayers(net,"adjust_bn_3","normal_add_3_3/in2");
net = connectLayers(net,"adjust_bn_3","normal_concat_3/in1");
net = connectLayers(net,"normal_bn_1_3","activation_320");
net = connectLayers(net,"normal_bn_1_3","activation_328");
net = connectLayers(net,"normal_bn_1_3","normal_left3_3");
net = connectLayers(net,"normal_bn_1_3","normal_add_5_3/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_3","normal_add_1_3/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_3","normal_add_1_3/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_3","normal_add_2_3/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_3","normal_add_2_3/in2");
net = connectLayers(net,"normal_left3_3","normal_add_3_3/in1");
net = connectLayers(net,"normal_left4_3","normal_add_4_3/in1");
net = connectLayers(net,"normal_right4_3","normal_add_4_3/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_3","normal_add_5_3/in1");
net = connectLayers(net,"normal_add_1_3","normal_concat_3/in2");
net = connectLayers(net,"normal_add_2_3","normal_concat_3/in3");
net = connectLayers(net,"normal_add_3_3","normal_concat_3/in4");
net = connectLayers(net,"normal_add_4_3","normal_concat_3/in5");
net = connectLayers(net,"normal_add_5_3","normal_concat_3/in6");
net = connectLayers(net,"normal_concat_3","activation_331");
net = connectLayers(net,"normal_concat_3","activation_342");
net = connectLayers(net,"adjust_bn_4","activation_334");
net = connectLayers(net,"adjust_bn_4","activation_336");
net = connectLayers(net,"adjust_bn_4","activation_338");
net = connectLayers(net,"adjust_bn_4","normal_left4_4");
net = connectLayers(net,"adjust_bn_4","normal_right4_4");
net = connectLayers(net,"adjust_bn_4","normal_add_3_4/in2");
net = connectLayers(net,"adjust_bn_4","normal_concat_4/in1");
net = connectLayers(net,"normal_bn_1_4","activation_332");
net = connectLayers(net,"normal_bn_1_4","activation_340");
net = connectLayers(net,"normal_bn_1_4","normal_left3_4");
net = connectLayers(net,"normal_bn_1_4","normal_add_5_4/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_4","normal_add_1_4/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_4","normal_add_1_4/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_4","normal_add_2_4/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_4","normal_add_2_4/in2");
net = connectLayers(net,"normal_left3_4","normal_add_3_4/in1");
net = connectLayers(net,"normal_left4_4","normal_add_4_4/in1");
net = connectLayers(net,"normal_right4_4","normal_add_4_4/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_4","normal_add_5_4/in1");
net = connectLayers(net,"normal_add_1_4","normal_concat_4/in2");
net = connectLayers(net,"normal_add_2_4","normal_concat_4/in3");
net = connectLayers(net,"normal_add_3_4","normal_concat_4/in4");
net = connectLayers(net,"normal_add_4_4","normal_concat_4/in5");
net = connectLayers(net,"normal_add_5_4","normal_concat_4/in6");
net = connectLayers(net,"normal_concat_4","activation_343");
net = connectLayers(net,"normal_concat_4","activation_354");
net = connectLayers(net,"normal_concat_4","adjust_relu_1_7");
net = connectLayers(net,"adjust_bn_5","activation_346");
net = connectLayers(net,"adjust_bn_5","activation_348");
net = connectLayers(net,"adjust_bn_5","activation_350");
net = connectLayers(net,"adjust_bn_5","normal_left4_5");
net = connectLayers(net,"adjust_bn_5","normal_right4_5");
net = connectLayers(net,"adjust_bn_5","normal_add_3_5/in2");
net = connectLayers(net,"adjust_bn_5","normal_concat_5/in1");
net = connectLayers(net,"normal_bn_1_5","activation_344");
net = connectLayers(net,"normal_bn_1_5","activation_352");
net = connectLayers(net,"normal_bn_1_5","normal_left3_5");
net = connectLayers(net,"normal_bn_1_5","normal_add_5_5/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_5","normal_add_1_5/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_5","normal_add_1_5/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_5","normal_add_2_5/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_5","normal_add_2_5/in2");
net = connectLayers(net,"normal_left3_5","normal_add_3_5/in1");
net = connectLayers(net,"normal_left4_5","normal_add_4_5/in1");
net = connectLayers(net,"normal_right4_5","normal_add_4_5/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_5","normal_add_5_5/in1");
net = connectLayers(net,"normal_add_1_5","normal_concat_5/in2");
net = connectLayers(net,"normal_add_2_5","normal_concat_5/in3");
net = connectLayers(net,"normal_add_3_5","normal_concat_5/in4");
net = connectLayers(net,"normal_add_4_5","normal_concat_5/in5");
net = connectLayers(net,"normal_add_5_5","normal_concat_5/in6");
net = connectLayers(net,"reduction_bn_1_reduce_6","activation_356");
net = connectLayers(net,"reduction_bn_1_reduce_6","reduction_left2_reduce_6");
net = connectLayers(net,"reduction_bn_1_reduce_6","reduction_left3_reduce_6");
net = connectLayers(net,"reduction_bn_1_reduce_6","reduction_right5_reduce_6");
net = connectLayers(net,"adjust_bn_reduce_6","activation_358");
net = connectLayers(net,"adjust_bn_reduce_6","activation_360");
net = connectLayers(net,"adjust_bn_reduce_6","activation_362");
net = connectLayers(net,"separable_conv_2_bn_reduction_left1_reduce_6","reduction_add_1_reduce_6/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right1_reduce_6","reduction_add_1_reduce_6/in2");
net = connectLayers(net,"reduction_add_1_reduce_6","activation_364");
net = connectLayers(net,"reduction_add_1_reduce_6","reduction_left4_reduce_6");
net = connectLayers(net,"reduction_left2_reduce_6","reduction_add_2_reduce_6/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right2_reduce_6","reduction_add_2_reduce_6/in2");
net = connectLayers(net,"adjust_relu_1_7","zero_padding2d_7");
net = connectLayers(net,"adjust_relu_1_7","cropping2d_7/ref");
net = connectLayers(net,"adjust_relu_1_7","adjust_avg_pool_1_7");
net = connectLayers(net,"reduction_add_2_reduce_6","add_7/in1");
net = connectLayers(net,"reduction_add_2_reduce_6","reduction_concat_reduce_6/in1");
net = connectLayers(net,"reduction_left3_reduce_6","reduction_add3_reduce_6/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right3_reduce_6","reduction_add3_reduce_6/in2");
net = connectLayers(net,"reduction_left4_reduce_6","add_7/in2");
net = connectLayers(net,"separable_conv_2_bn_reduction_left4_reduce_6","reduction_add4_reduce_6/in1");
net = connectLayers(net,"reduction_right5_reduce_6","reduction_add4_reduce_6/in2");
net = connectLayers(net,"zero_padding2d_7","cropping2d_7/in");
net = connectLayers(net,"reduction_add3_reduce_6","reduction_concat_reduce_6/in2");
net = connectLayers(net,"add_7","reduction_concat_reduce_6/in3");
net = connectLayers(net,"reduction_add4_reduce_6","reduction_concat_reduce_6/in4");
net = connectLayers(net,"reduction_concat_reduce_6","activation_366");
net = connectLayers(net,"reduction_concat_reduce_6","activation_377");
net = connectLayers(net,"adjust_conv_1_7","concatenate_7/in1");
net = connectLayers(net,"adjust_conv_2_7","concatenate_7/in2");
net = connectLayers(net,"adjust_bn_7","activation_369");
net = connectLayers(net,"adjust_bn_7","activation_371");
net = connectLayers(net,"adjust_bn_7","activation_373");
net = connectLayers(net,"adjust_bn_7","normal_left4_7");
net = connectLayers(net,"adjust_bn_7","normal_right4_7");
net = connectLayers(net,"adjust_bn_7","normal_add_3_7/in2");
net = connectLayers(net,"adjust_bn_7","normal_concat_7/in1");
net = connectLayers(net,"normal_bn_1_7","activation_367");
net = connectLayers(net,"normal_bn_1_7","activation_375");
net = connectLayers(net,"normal_bn_1_7","normal_left3_7");
net = connectLayers(net,"normal_bn_1_7","normal_add_5_7/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_7","normal_add_1_7/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_7","normal_add_1_7/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_7","normal_add_2_7/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_7","normal_add_2_7/in2");
net = connectLayers(net,"normal_left3_7","normal_add_3_7/in1");
net = connectLayers(net,"normal_left4_7","normal_add_4_7/in1");
net = connectLayers(net,"normal_right4_7","normal_add_4_7/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_7","normal_add_5_7/in1");
net = connectLayers(net,"normal_add_1_7","normal_concat_7/in2");
net = connectLayers(net,"normal_add_2_7","normal_concat_7/in3");
net = connectLayers(net,"normal_add_3_7","normal_concat_7/in4");
net = connectLayers(net,"normal_add_4_7","normal_concat_7/in5");
net = connectLayers(net,"normal_add_5_7","normal_concat_7/in6");
net = connectLayers(net,"normal_concat_7","activation_378");
net = connectLayers(net,"normal_concat_7","activation_389");
net = connectLayers(net,"adjust_bn_8","activation_381");
net = connectLayers(net,"adjust_bn_8","activation_383");
net = connectLayers(net,"adjust_bn_8","activation_385");
net = connectLayers(net,"adjust_bn_8","normal_left4_8");
net = connectLayers(net,"adjust_bn_8","normal_right4_8");
net = connectLayers(net,"adjust_bn_8","normal_add_3_8/in2");
net = connectLayers(net,"adjust_bn_8","normal_concat_8/in1");
net = connectLayers(net,"normal_bn_1_8","activation_379");
net = connectLayers(net,"normal_bn_1_8","activation_387");
net = connectLayers(net,"normal_bn_1_8","normal_left3_8");
net = connectLayers(net,"normal_bn_1_8","normal_add_5_8/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_8","normal_add_1_8/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_8","normal_add_1_8/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_8","normal_add_2_8/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_8","normal_add_2_8/in2");
net = connectLayers(net,"normal_left3_8","normal_add_3_8/in1");
net = connectLayers(net,"normal_left4_8","normal_add_4_8/in1");
net = connectLayers(net,"normal_right4_8","normal_add_4_8/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_8","normal_add_5_8/in1");
net = connectLayers(net,"normal_add_1_8","normal_concat_8/in2");
net = connectLayers(net,"normal_add_2_8","normal_concat_8/in3");
net = connectLayers(net,"normal_add_3_8","normal_concat_8/in4");
net = connectLayers(net,"normal_add_4_8","normal_concat_8/in5");
net = connectLayers(net,"normal_add_5_8","normal_concat_8/in6");
net = connectLayers(net,"normal_concat_8","activation_390");
net = connectLayers(net,"normal_concat_8","activation_401");
net = connectLayers(net,"adjust_bn_9","activation_393");
net = connectLayers(net,"adjust_bn_9","activation_395");
net = connectLayers(net,"adjust_bn_9","activation_397");
net = connectLayers(net,"adjust_bn_9","normal_left4_9");
net = connectLayers(net,"adjust_bn_9","normal_right4_9");
net = connectLayers(net,"adjust_bn_9","normal_add_3_9/in2");
net = connectLayers(net,"adjust_bn_9","normal_concat_9/in1");
net = connectLayers(net,"normal_bn_1_9","activation_391");
net = connectLayers(net,"normal_bn_1_9","activation_399");
net = connectLayers(net,"normal_bn_1_9","normal_left3_9");
net = connectLayers(net,"normal_bn_1_9","normal_add_5_9/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_9","normal_add_1_9/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_9","normal_add_1_9/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_9","normal_add_2_9/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_9","normal_add_2_9/in2");
net = connectLayers(net,"normal_left3_9","normal_add_3_9/in1");
net = connectLayers(net,"normal_left4_9","normal_add_4_9/in1");
net = connectLayers(net,"normal_right4_9","normal_add_4_9/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_9","normal_add_5_9/in1");
net = connectLayers(net,"normal_add_1_9","normal_concat_9/in2");
net = connectLayers(net,"normal_add_2_9","normal_concat_9/in3");
net = connectLayers(net,"normal_add_3_9","normal_concat_9/in4");
net = connectLayers(net,"normal_add_4_9","normal_concat_9/in5");
net = connectLayers(net,"normal_add_5_9","normal_concat_9/in6");
net = connectLayers(net,"normal_concat_9","activation_402");
net = connectLayers(net,"normal_concat_9","activation_413");
net = connectLayers(net,"adjust_bn_10","activation_405");
net = connectLayers(net,"adjust_bn_10","activation_407");
net = connectLayers(net,"adjust_bn_10","activation_409");
net = connectLayers(net,"adjust_bn_10","normal_left4_10");
net = connectLayers(net,"adjust_bn_10","normal_right4_10");
net = connectLayers(net,"adjust_bn_10","normal_add_3_10/in2");
net = connectLayers(net,"adjust_bn_10","normal_concat_10/in1");
net = connectLayers(net,"normal_bn_1_10","activation_403");
net = connectLayers(net,"normal_bn_1_10","activation_411");
net = connectLayers(net,"normal_bn_1_10","normal_left3_10");
net = connectLayers(net,"normal_bn_1_10","normal_add_5_10/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_10","normal_add_1_10/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_10","normal_add_1_10/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_10","normal_add_2_10/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_10","normal_add_2_10/in2");
net = connectLayers(net,"normal_left3_10","normal_add_3_10/in1");
net = connectLayers(net,"normal_left4_10","normal_add_4_10/in1");
net = connectLayers(net,"normal_right4_10","normal_add_4_10/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_10","normal_add_5_10/in1");
net = connectLayers(net,"normal_add_1_10","normal_concat_10/in2");
net = connectLayers(net,"normal_add_2_10","normal_concat_10/in3");
net = connectLayers(net,"normal_add_3_10","normal_concat_10/in4");
net = connectLayers(net,"normal_add_4_10","normal_concat_10/in5");
net = connectLayers(net,"normal_add_5_10","normal_concat_10/in6");
net = connectLayers(net,"normal_concat_10","activation_414");
net = connectLayers(net,"normal_concat_10","activation_425");
net = connectLayers(net,"adjust_bn_11","activation_417");
net = connectLayers(net,"adjust_bn_11","activation_419");
net = connectLayers(net,"adjust_bn_11","activation_421");
net = connectLayers(net,"adjust_bn_11","normal_left4_11");
net = connectLayers(net,"adjust_bn_11","normal_right4_11");
net = connectLayers(net,"adjust_bn_11","normal_add_3_11/in2");
net = connectLayers(net,"adjust_bn_11","normal_concat_11/in1");
net = connectLayers(net,"normal_bn_1_11","activation_415");
net = connectLayers(net,"normal_bn_1_11","activation_423");
net = connectLayers(net,"normal_bn_1_11","normal_left3_11");
net = connectLayers(net,"normal_bn_1_11","normal_add_5_11/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_11","normal_add_1_11/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_11","normal_add_1_11/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_11","normal_add_2_11/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_11","normal_add_2_11/in2");
net = connectLayers(net,"normal_left3_11","normal_add_3_11/in1");
net = connectLayers(net,"normal_left4_11","normal_add_4_11/in1");
net = connectLayers(net,"normal_right4_11","normal_add_4_11/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_11","normal_add_5_11/in1");
net = connectLayers(net,"normal_add_1_11","normal_concat_11/in2");
net = connectLayers(net,"normal_add_2_11","normal_concat_11/in3");
net = connectLayers(net,"normal_add_3_11","normal_concat_11/in4");
net = connectLayers(net,"normal_add_4_11","normal_concat_11/in5");
net = connectLayers(net,"normal_add_5_11","normal_concat_11/in6");
net = connectLayers(net,"normal_concat_11","activation_426");
net = connectLayers(net,"normal_concat_11","activation_437");
net = connectLayers(net,"normal_concat_11","adjust_relu_1_13");
net = connectLayers(net,"adjust_bn_12","activation_429");
net = connectLayers(net,"adjust_bn_12","activation_431");
net = connectLayers(net,"adjust_bn_12","activation_433");
net = connectLayers(net,"adjust_bn_12","normal_left4_12");
net = connectLayers(net,"adjust_bn_12","normal_right4_12");
net = connectLayers(net,"adjust_bn_12","normal_add_3_12/in2");
net = connectLayers(net,"adjust_bn_12","normal_concat_12/in1");
net = connectLayers(net,"normal_bn_1_12","activation_427");
net = connectLayers(net,"normal_bn_1_12","activation_435");
net = connectLayers(net,"normal_bn_1_12","normal_left3_12");
net = connectLayers(net,"normal_bn_1_12","normal_add_5_12/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_12","normal_add_1_12/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_12","normal_add_1_12/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_12","normal_add_2_12/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_12","normal_add_2_12/in2");
net = connectLayers(net,"normal_left3_12","normal_add_3_12/in1");
net = connectLayers(net,"normal_left4_12","normal_add_4_12/in1");
net = connectLayers(net,"normal_right4_12","normal_add_4_12/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_12","normal_add_5_12/in1");
net = connectLayers(net,"normal_add_1_12","normal_concat_12/in2");
net = connectLayers(net,"normal_add_2_12","normal_concat_12/in3");
net = connectLayers(net,"normal_add_3_12","normal_concat_12/in4");
net = connectLayers(net,"normal_add_4_12","normal_concat_12/in5");
net = connectLayers(net,"normal_add_5_12","normal_concat_12/in6");
net = connectLayers(net,"reduction_bn_1_reduce_12","activation_439");
net = connectLayers(net,"reduction_bn_1_reduce_12","reduction_left2_reduce_12");
net = connectLayers(net,"reduction_bn_1_reduce_12","reduction_left3_reduce_12");
net = connectLayers(net,"reduction_bn_1_reduce_12","reduction_right5_reduce_12");
net = connectLayers(net,"adjust_bn_reduce_12","activation_441");
net = connectLayers(net,"adjust_bn_reduce_12","activation_443");
net = connectLayers(net,"adjust_bn_reduce_12","activation_445");
net = connectLayers(net,"separable_conv_2_bn_reduction_left1_reduce_12","reduction_add_1_reduce_12/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right1_reduce_12","reduction_add_1_reduce_12/in2");
net = connectLayers(net,"reduction_add_1_reduce_12","activation_447");
net = connectLayers(net,"reduction_add_1_reduce_12","reduction_left4_reduce_12");
net = connectLayers(net,"reduction_left2_reduce_12","reduction_add_2_reduce_12/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right2_reduce_12","reduction_add_2_reduce_12/in2");
net = connectLayers(net,"adjust_relu_1_13","zero_padding2d_8");
net = connectLayers(net,"adjust_relu_1_13","cropping2d_8/ref");
net = connectLayers(net,"adjust_relu_1_13","adjust_avg_pool_1_13");
net = connectLayers(net,"reduction_add_2_reduce_12","add_8/in1");
net = connectLayers(net,"reduction_add_2_reduce_12","reduction_concat_reduce_12/in1");
net = connectLayers(net,"reduction_left3_reduce_12","reduction_add3_reduce_12/in1");
net = connectLayers(net,"separable_conv_2_bn_reduction_right3_reduce_12","reduction_add3_reduce_12/in2");
net = connectLayers(net,"reduction_left4_reduce_12","add_8/in2");
net = connectLayers(net,"separable_conv_2_bn_reduction_left4_reduce_12","reduction_add4_reduce_12/in1");
net = connectLayers(net,"reduction_right5_reduce_12","reduction_add4_reduce_12/in2");
net = connectLayers(net,"zero_padding2d_8","cropping2d_8/in");
net = connectLayers(net,"reduction_add3_reduce_12","reduction_concat_reduce_12/in2");
net = connectLayers(net,"add_8","reduction_concat_reduce_12/in3");
net = connectLayers(net,"reduction_add4_reduce_12","reduction_concat_reduce_12/in4");
net = connectLayers(net,"reduction_concat_reduce_12","activation_449");
net = connectLayers(net,"reduction_concat_reduce_12","activation_460");
net = connectLayers(net,"adjust_conv_1_13","concatenate_8/in1");
net = connectLayers(net,"adjust_conv_2_13","concatenate_8/in2");
net = connectLayers(net,"adjust_bn_13","activation_452");
net = connectLayers(net,"adjust_bn_13","activation_454");
net = connectLayers(net,"adjust_bn_13","activation_456");
net = connectLayers(net,"adjust_bn_13","normal_left4_13");
net = connectLayers(net,"adjust_bn_13","normal_right4_13");
net = connectLayers(net,"adjust_bn_13","normal_add_3_13/in2");
net = connectLayers(net,"adjust_bn_13","normal_concat_13/in1");
net = connectLayers(net,"normal_bn_1_13","activation_450");
net = connectLayers(net,"normal_bn_1_13","activation_458");
net = connectLayers(net,"normal_bn_1_13","normal_left3_13");
net = connectLayers(net,"normal_bn_1_13","normal_add_5_13/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_13","normal_add_1_13/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_13","normal_add_1_13/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_13","normal_add_2_13/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_13","normal_add_2_13/in2");
net = connectLayers(net,"normal_left3_13","normal_add_3_13/in1");
net = connectLayers(net,"normal_left4_13","normal_add_4_13/in1");
net = connectLayers(net,"normal_right4_13","normal_add_4_13/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_13","normal_add_5_13/in1");
net = connectLayers(net,"normal_add_1_13","normal_concat_13/in2");
net = connectLayers(net,"normal_add_2_13","normal_concat_13/in3");
net = connectLayers(net,"normal_add_3_13","normal_concat_13/in4");
net = connectLayers(net,"normal_add_4_13","normal_concat_13/in5");
net = connectLayers(net,"normal_add_5_13","normal_concat_13/in6");
net = connectLayers(net,"normal_concat_13","activation_461");
net = connectLayers(net,"normal_concat_13","activation_472");
net = connectLayers(net,"adjust_bn_14","activation_464");
net = connectLayers(net,"adjust_bn_14","activation_466");
net = connectLayers(net,"adjust_bn_14","activation_468");
net = connectLayers(net,"adjust_bn_14","normal_left4_14");
net = connectLayers(net,"adjust_bn_14","normal_right4_14");
net = connectLayers(net,"adjust_bn_14","normal_add_3_14/in2");
net = connectLayers(net,"adjust_bn_14","normal_concat_14/in1");
net = connectLayers(net,"normal_bn_1_14","activation_462");
net = connectLayers(net,"normal_bn_1_14","activation_470");
net = connectLayers(net,"normal_bn_1_14","normal_left3_14");
net = connectLayers(net,"normal_bn_1_14","normal_add_5_14/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_14","normal_add_1_14/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_14","normal_add_1_14/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_14","normal_add_2_14/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_14","normal_add_2_14/in2");
net = connectLayers(net,"normal_left3_14","normal_add_3_14/in1");
net = connectLayers(net,"normal_left4_14","normal_add_4_14/in1");
net = connectLayers(net,"normal_right4_14","normal_add_4_14/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_14","normal_add_5_14/in1");
net = connectLayers(net,"normal_add_1_14","normal_concat_14/in2");
net = connectLayers(net,"normal_add_2_14","normal_concat_14/in3");
net = connectLayers(net,"normal_add_3_14","normal_concat_14/in4");
net = connectLayers(net,"normal_add_4_14","normal_concat_14/in5");
net = connectLayers(net,"normal_add_5_14","normal_concat_14/in6");
net = connectLayers(net,"normal_concat_14","activation_473");
net = connectLayers(net,"normal_concat_14","activation_484");
net = connectLayers(net,"adjust_bn_15","activation_476");
net = connectLayers(net,"adjust_bn_15","activation_478");
net = connectLayers(net,"adjust_bn_15","activation_480");
net = connectLayers(net,"adjust_bn_15","normal_left4_15");
net = connectLayers(net,"adjust_bn_15","normal_right4_15");
net = connectLayers(net,"adjust_bn_15","normal_add_3_15/in2");
net = connectLayers(net,"adjust_bn_15","normal_concat_15/in1");
net = connectLayers(net,"normal_bn_1_15","activation_474");
net = connectLayers(net,"normal_bn_1_15","activation_482");
net = connectLayers(net,"normal_bn_1_15","normal_left3_15");
net = connectLayers(net,"normal_bn_1_15","normal_add_5_15/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_15","normal_add_1_15/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_15","normal_add_1_15/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_15","normal_add_2_15/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_15","normal_add_2_15/in2");
net = connectLayers(net,"normal_left3_15","normal_add_3_15/in1");
net = connectLayers(net,"normal_left4_15","normal_add_4_15/in1");
net = connectLayers(net,"normal_right4_15","normal_add_4_15/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_15","normal_add_5_15/in1");
net = connectLayers(net,"normal_add_1_15","normal_concat_15/in2");
net = connectLayers(net,"normal_add_2_15","normal_concat_15/in3");
net = connectLayers(net,"normal_add_3_15","normal_concat_15/in4");
net = connectLayers(net,"normal_add_4_15","normal_concat_15/in5");
net = connectLayers(net,"normal_add_5_15","normal_concat_15/in6");
net = connectLayers(net,"normal_concat_15","activation_485");
net = connectLayers(net,"normal_concat_15","activation_496");
net = connectLayers(net,"adjust_bn_16","activation_488");
net = connectLayers(net,"adjust_bn_16","activation_490");
net = connectLayers(net,"adjust_bn_16","activation_492");
net = connectLayers(net,"adjust_bn_16","normal_left4_16");
net = connectLayers(net,"adjust_bn_16","normal_right4_16");
net = connectLayers(net,"adjust_bn_16","normal_add_3_16/in2");
net = connectLayers(net,"adjust_bn_16","normal_concat_16/in1");
net = connectLayers(net,"normal_bn_1_16","activation_486");
net = connectLayers(net,"normal_bn_1_16","activation_494");
net = connectLayers(net,"normal_bn_1_16","normal_left3_16");
net = connectLayers(net,"normal_bn_1_16","normal_add_5_16/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_16","normal_add_1_16/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_16","normal_add_1_16/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_16","normal_add_2_16/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_16","normal_add_2_16/in2");
net = connectLayers(net,"normal_left3_16","normal_add_3_16/in1");
net = connectLayers(net,"normal_left4_16","normal_add_4_16/in1");
net = connectLayers(net,"normal_right4_16","normal_add_4_16/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_16","normal_add_5_16/in1");
net = connectLayers(net,"normal_add_1_16","normal_concat_16/in2");
net = connectLayers(net,"normal_add_2_16","normal_concat_16/in3");
net = connectLayers(net,"normal_add_3_16","normal_concat_16/in4");
net = connectLayers(net,"normal_add_4_16","normal_concat_16/in5");
net = connectLayers(net,"normal_add_5_16","normal_concat_16/in6");
net = connectLayers(net,"normal_concat_16","activation_497");
net = connectLayers(net,"normal_concat_16","activation_508");
net = connectLayers(net,"adjust_bn_17","activation_500");
net = connectLayers(net,"adjust_bn_17","activation_502");
net = connectLayers(net,"adjust_bn_17","activation_504");
net = connectLayers(net,"adjust_bn_17","normal_left4_17");
net = connectLayers(net,"adjust_bn_17","normal_right4_17");
net = connectLayers(net,"adjust_bn_17","normal_add_3_17/in2");
net = connectLayers(net,"adjust_bn_17","normal_concat_17/in1");
net = connectLayers(net,"normal_bn_1_17","activation_498");
net = connectLayers(net,"normal_bn_1_17","activation_506");
net = connectLayers(net,"normal_bn_1_17","normal_left3_17");
net = connectLayers(net,"normal_bn_1_17","normal_add_5_17/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_17","normal_add_1_17/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_17","normal_add_1_17/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_17","normal_add_2_17/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_17","normal_add_2_17/in2");
net = connectLayers(net,"normal_left3_17","normal_add_3_17/in1");
net = connectLayers(net,"normal_left4_17","normal_add_4_17/in1");
net = connectLayers(net,"normal_right4_17","normal_add_4_17/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_17","normal_add_5_17/in1");
net = connectLayers(net,"normal_add_1_17","normal_concat_17/in2");
net = connectLayers(net,"normal_add_2_17","normal_concat_17/in3");
net = connectLayers(net,"normal_add_3_17","normal_concat_17/in4");
net = connectLayers(net,"normal_add_4_17","normal_concat_17/in5");
net = connectLayers(net,"normal_add_5_17","normal_concat_17/in6");
net = connectLayers(net,"adjust_bn_18","activation_512");
net = connectLayers(net,"adjust_bn_18","activation_514");
net = connectLayers(net,"adjust_bn_18","activation_516");
net = connectLayers(net,"adjust_bn_18","normal_left4_18");
net = connectLayers(net,"adjust_bn_18","normal_right4_18");
net = connectLayers(net,"adjust_bn_18","normal_add_3_18/in2");
net = connectLayers(net,"adjust_bn_18","normal_concat_18/in1");
net = connectLayers(net,"normal_bn_1_18","activation_510");
net = connectLayers(net,"normal_bn_1_18","activation_518");
net = connectLayers(net,"normal_bn_1_18","normal_left3_18");
net = connectLayers(net,"normal_bn_1_18","normal_add_5_18/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left1_18","normal_add_1_18/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right1_18","normal_add_1_18/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left2_18","normal_add_2_18/in1");
net = connectLayers(net,"separable_conv_2_bn_normal_right2_18","normal_add_2_18/in2");
net = connectLayers(net,"normal_left3_18","normal_add_3_18/in1");
net = connectLayers(net,"normal_left4_18","normal_add_4_18/in1");
net = connectLayers(net,"normal_right4_18","normal_add_4_18/in2");
net = connectLayers(net,"separable_conv_2_bn_normal_left5_18","normal_add_5_18/in1");
net = connectLayers(net,"normal_add_1_18","normal_concat_18/in2");
net = connectLayers(net,"normal_add_2_18","normal_concat_18/in3");
net = connectLayers(net,"normal_add_3_18","normal_concat_18/in4");
net = connectLayers(net,"normal_add_4_18","normal_concat_18/in5");
net = connectLayers(net,"normal_add_5_18","normal_concat_18/in6");
net = initialize(net);
end