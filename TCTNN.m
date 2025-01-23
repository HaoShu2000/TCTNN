function [XX,MAE,RMSE] = TCTNN(X0,P_t,k,rho,mu)

%% toolbox
addpath(genpath('high-order tensor-SVD Toolbox'));


%% default paremeters setting

n=k;
dim =size(X0);
C_dim=[dim(1),n,dim(2),dim(3)];
missingrate=P_t/dim(1);
missingway='t-Norandom';
switch missingway 
      case 't-Norandom'
            Pomega=zeros(dim(1),dim(2),dim(3));
            Pomega(1:dim(1)-P_t,:,:)=ones(dim(1)-P_t,dim(2),dim(3));      
end
Pomegac=1-Pomega;

tol        = 1e-3; 
max_iter   = 400;
max_mu     = 1e10;

%% variables initialization
X            = Pomega.*X0;
G            = zeros(C_dim); 
M            = zeros(C_dim); 

start_time = tic;
%% main loop
iter = 0;
while iter<max_iter
    iter = iter + 1;  
    %% Update G

       
              G = prox_htnn_F(tconv_3_T12(X,n)-M/mu,1/mu);
 
    %% Updata X -- proximal operator of TNN
    Z=tconv_3inv_T12(G+M/mu);
    X=Pomegac.*Z+Pomega.*X0;
    MAE=(1/(prod(dim)*missingrate))*sum(abs(Pomegac.*X0-Pomegac.*X),'all');
    RMSE=1/sqrt(prod(dim)*missingrate)*sqrt(sum((Pomegac.*X0-Pomegac.*X).^2,'all'));
    %% Stop criterion
    dY   =  G-tconv_3_T12(X,n);    
    chg  = max(abs(dY(:)));
    if chg < tol
         break;
    end    
    %% Update detail display
        if iter == 1 || mod(iter, 30) == 0
            err = norm(dY(:),'fro');
            disp(['iter= ' num2str(iter) ', mu=' num2str(mu) ...
                   ', chg=' num2str(chg)  ...
                     ', err=' num2str(err) ',  MAE=' num2str(MAE) ...
                     ',  RMSE=' num2str( RMSE)]); 
        end
     
    %% Update mulipliers
    M = M+mu*(G-tconv_3_T12(X,n));
    mu = min(rho*mu,max_mu);
end
elapsed_time = toc(start_time);
disp(['程序运行时间为 ', num2str(elapsed_time/60), '分钟']);
XX= ipermute(X,[3,1,2]);
%imshow(XX(:,:,60));
end

