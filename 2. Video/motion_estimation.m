% L.B.I.P Thilakasiri - E/16/367

% Contents:- Motion Estimation Function

 % Motion Estimation
function [recon, compensated] = motion_estimation(predicted_intra_frame, next_frame, block_size)
     [compensated, residue] = motionVec_and_Residue(block_size, predicted_intra_frame, next_frame);
     decoded_residue1 = residue;
     recon = (decoded_residue1) + (compensated);
     
     figure; subplot(1,3,1); imshow((residue)); title('Residue');
             subplot(1,3,2); imshow(compensated); title('Compensated Image');
             subplot(1,3,3); imshow(recon); title('Output After Residue Addition');
             %suptitle(sprintf('Residue, Compensated & Final Output - E/16/367'));
end