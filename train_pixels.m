tic
clear all
%------------------------------------------------------------------%
% parameters
training_number = [1:5:1000];   % In this case there are 200 objects per class, change 5 to 100 to get scenario 2.
resize = [40 20];  
Angle = -20:20:20;  % Using only 3 angles
global W;

%-----------------------------------------------------------------%
a = prnist([0:9], training_number)
im_a = data2im(a);
nlab = getnlab(a);
lablist = getlablist(a);

len = length(Angle);
if(isempty(find(Angle == 0, 1)))
    len = len + 1;
end

trainSets = zeros([len*length(im_a) prod(resize)]);

for i = 1:length(im_a)
    temp = preprocessing(im_a{i}, resize, Angle);
    trainSets((i-1)*size(temp,1)+1 : i*size(temp,1), :) = temp;
end
trainSets = prdataset(trainSets, '1');

trainSets = setlablist(trainSets, lablist);
nn = repmat(nlab', length(Angle), 1);
nn = reshape(nn, [1 size(nn, 1)*size(nn, 2)]);
trainSets = setnlab(trainSets, nn');
trainSets = setprior(trainSets,0);
%% Feature reduction using Fisher

  W = nlfisherm(trainSets,9);
  trainSets_f = trainSets*W; % W - fisher mapping
%% Classification  
%  w = qdc(trainSets_f);       % As an example only 2 classifiers are shown
   w = knnc(trainSets_f,3);
%%  Cross - validation 
% [ERR,~,~,~] = prcrossval(trainSets_f,knnc,10,1,w); 


 
 
