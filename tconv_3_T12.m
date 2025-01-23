function [C] = tconv_3_T12(X,n)

dim=size(X);
dimd=[dim(1) n dim(2) dim(3)];
C=zeros(dimd);

for i=1:dim(2)
    for j=1:dim(3)
        for t_n=1:n
            C(:,t_n,i,j)=X(:,i,j);
             if t_n < n
                 X(:,i,j) = circshift(X(:,i,j),1);
             end
        end
    end
end

% dim=size(X);
% dimd=[n dim];
% C=zeros(dimd);
% 
% for i=1:dim(2)
%     for j=1:dim(3)
%         for t_n=1:n
%             C(t_n,:,i,j)=X(:,i,j);
%              if t_n < n
%                  X(:,i,j) = circshift(X(:,i,j),1);
%              end
%         end
%     end
% end


end
