% % % % %generando la mask
% % % % nFiltSize = 8;
% % % % nFiltRadius = 2;
% % % % filtR = generateRadialFilterLBP(nFiltSize, nFiltRadius);

% % %     %calcular lbp
% % %     %effLBP = efficientLBP(Iwnd, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);    
% % %     effRILBP= efficientLBP(Iwnd, 'filtR', filtR, 'isRotInv', true, 'isChanWiseRot', false);
% % %     
% % %     uniqueRotInvLBP=findUniqValsRILBP(nFiltSize);
% % %     tightValsRILBP=1:length(uniqueRotInvLBP);
% % %     % Use this function with caution- it is relevant only if 'isChanWiseRot' is false, or the
% % %     % input image is single-color/grayscale
% % %     effTightRILBP=tightHistImg(effRILBP, 'inMap', uniqueRotInvLBP, 'outMap', tightValsRILBP);
% % % 
% % %     
% % %     %binsRange=(1:2^nFiltSize)-1;
% % %     %h = [h hist(single( effLBP(:) ), binsRange)];
% % %     h=[h hist(single( effTightRILBP(:) ), tightValsRILBP)];


%using uniform patterns
% figure(1), stem(h);

% % % % % % %calcular lbp
% % % % % % %effLBP = efficientLBP(Iwnd, 'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
% % % % % % effRILBP= efficientLBP(I, 'filtR', filtR, 'isRotInv', true, 'isChanWiseRot', false);
% % % % % % 
% % % % % % uniqueRotInvLBP=findUniqValsRILBP(nFiltSize);
% % % % % % tightValsRILBP=1:length(uniqueRotInvLBP);
% % % % % % % Use this function with caution- it is relevant only if 'isChanWiseRot' is false, or the
% % % % % % % input image is single-color/grayscale
% % % % % % effTightRILBP=tightHistImg(effRILBP, 'inMap', uniqueRotInvLBP, 'outMap', tightValsRILBP);
% % % % % % 
% % % % % % 
% % % % % % %binsRange=(1:2^nFiltSize)-1;
% % % % % % %h = [h hist(single( effLBP(:) ), binsRange)];
% % % % % % h =  hist(single( effTightRILBP(:) ), tightValsRILBP);


% % % mapping=getmapping(8,'u2');
% % % h=Lbp(I,2,8,mapping,'h'); %LBP histogram in (8,1) neighborhood
% % % %using uniform patterns
% % % figure(1), stem(h);




% % effaRILBP= efficientLBP(img, 'filtR', filtR, 'isRotInv', true, 'isChanWiseRot', false);

% % uniqueRotInvLBP=findUniqValsRILBP(nFiltSize);
% % tightValsRILBP=1:length(uniqueRotInvLBP);
% % % Use this function with caution- it is relevant only if 'isChanWiseRot' is false, or the
% % % input image is single-color/grayscale
% % effTightRILBP=tightHistImg(effRILBP, 'inMap', uniqueRotInvLBP, 'outMap', tightValsRILBP);
% % % binsRange=(1:2^nFiltSize)-1;
% % % figure;
% % % subplot(2,1,1)
% % % hist(single( effLBP(:) ), binsRange);
% % % axis tight;
% % % title('Regular LBP hsitogram', 'fontSize', 16);