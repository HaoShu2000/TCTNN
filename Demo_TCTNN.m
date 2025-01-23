disp("TCTNN_Temperature")
dataRoad = 'Temperature';
load(dataRoad);
Temperature=Temperature(:,:,1:50);
Temperature(find(Temperature>50))=0;
Temperature(find(Temperature==0))=mean(Temperature,'all');
X0=permute(Temperature,[3 1 2]);
dim=size(X0);
rho        = 1.1;
mu         = 1e-5;
for  k=[25] 
disp(['k=' num2str(k)]);    
for  Pt=[2 4 6 8 10]
        disp(['Pt=' num2str(Pt)]); 
         [~,MAE,RMSE]=TCTNN(X0,Pt,k,rho,mu); 
         disp(['MAE=' num2str(MAE)]);
         disp(['RMSE=' num2str(RMSE)]);
end
end

