% L.B.I.P Thilakasiri - E/16/367

% Contents:- Motion Vector & Residue Calculation

function [compensated, residue] = motionVec_and_Residue(block_size, frame1, frame2)
    
    predicted_frame = frame1;
    [Motion_Vector] = SAD_Calc(block_size, predicted_frame, frame2); 
    compensated = compensated_img(block_size, predicted_frame , Motion_Vector);
    residue = (frame2) - (compensated);
end