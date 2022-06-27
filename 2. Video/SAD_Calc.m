% L.B.I.P Thilakasiri - E/16/367

% Contents:- Sum of Absolute Differences (SAD) Calculation

function [Motion_Vector] = SAD_Calc(block_size, frame1, frame2)
    figure; subplot(1,2,1); imshow(frame1); title('Recieved Frame 1');
            subplot(1,2,2); imshow(frame2); title('Recieved Frame 2');
            %suptitle(sprintf('Recieved Frames - E/16/367'));
    
    % Variable Defining
    rows = 400; cols = 400;
    SAD_Vec = cell(rows/block_size , cols/block_size); % Empty Vector to Store Corresponding SAD Vals
    Motion_Vector = cell(rows/block_size , cols/block_size); % Empty Vector to Store MVs
   
    % Iterating through the Blocks & Look for Best Match
    for i = 1 : block_size : rows
        for j = 1 : block_size : cols
            SAD_Val = 1000000000000;
            M_Vect = zeros(1,2);
            
            % Division and Assignment of Blocks
            f2_blk = frame2(i:i+block_size-1, j:j+block_size-1); 
 
            for a = 1 : block_size : rows
                for b = 1 : block_size : cols
                    % Division and Assignment of Blocks
                    f1_blk = frame1(a:a+block_size-1, b:b+block_size-1);
                    dif = abs(double(f2_blk) - double(f1_blk));
                    Temp_SAD = sum(dif(:));

                     if (Temp_SAD < SAD_Val) 
                         M_Vect(1,1) = a; M_Vect(1,2) = b; SAD_Val = Temp_SAD;
                     end
                end
            end
            
            % Saving the Calculated and Updated Values to MV & SAD Vector
            x = ceil(i/block_size); y = ceil(j/block_size);
            Motion_Vector{x,y} = M_Vect;
            SAD_Vec{x,y} = SAD_Val; 
        end
    end
end

