function a = my_rep_pix(m)
%% Test set for nist_eval function
    global W;
    resize = [40 20];
    im_m = data2im(m);
    
    testSets = zeros([length(im_m) prod(resize)]);
    
    for i = 1:length(im_m)
        temp = preprocessing(im_m{i}, resize);
        testSets(i, :) = temp;    
    end
    testSets = testSets*W;
    a = prdataset(testSets, '1');
end