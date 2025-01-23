
function [X] = tconv_3inv_T12(C)
dim=size(C);
X=C(:,1,:,:);
X=reshape(X,dim(1),dim(3),dim(4));
% dim=size(C);
% X=C(1,:,:,:);
% X=reshape(X,dim(2),dim(3),dim(4));
end

