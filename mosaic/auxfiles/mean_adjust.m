function Ms2 = mean_adjust(M1,Ms)

M1 = double(M1);
Ms = double(Ms);
Ms2 = Ms;
Ms2(:,:,1) = Ms(:,:,1) - min(min(Ms(:,:,1)));
Ms2(:,:,1) = Ms2(:,:,1)./max(max(Ms2(:,:,1)));
Ms2(:,:,2) = Ms(:,:,2) - min(min(Ms(:,:,2)));
Ms2(:,:,2) = Ms2(:,:,2)./max(max(Ms2(:,:,2)));
Ms2(:,:,3) = Ms(:,:,3) - min(min(Ms(:,:,3)));
Ms2(:,:,3) = Ms2(:,:,3)./max(max(Ms2(:,:,3)));

Ms2(:,:,1) = Ms2(:,:,1).*(max(max(M1(:,:,1))));
Ms2(:,:,2) = Ms2(:,:,2).*(max(max(M1(:,:,2))));
Ms2(:,:,3) = Ms2(:,:,3).*(max(max(M1(:,:,3))));

