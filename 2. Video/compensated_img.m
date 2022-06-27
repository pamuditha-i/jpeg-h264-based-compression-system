% L.B.I.P Thilakasiri - E/16/367

% Contents:- Generate the Compensated Image by Moving the Blocks to the Best Matched Places

function compensated = compensated_img(block_size, pre_frame, Motion_Vector)
    % Variable Defining
    rows = 400; cols = 400; compensated = zeros(rows,cols);
    % Iterating through the Blocks & Constructing the Compensated Image
    for i = 1 : block_size : rows
        for j = 1 : block_size : cols
            % Defining the M_Vect
            M_Vect = Motion_Vector{ceil(i/block_size) , ceil(j/block_size)};
            % Creating the Compensated Image
            compensated(i:i+block_size-1, j:j+block_size-1) = pre_frame(M_Vect(1,1):M_Vect(1,1)+block_size-1, M_Vect(1,2):M_Vect(1,2)+block_size-1); 
        end
    end
end