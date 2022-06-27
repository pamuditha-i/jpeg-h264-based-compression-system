% L.B.I.P Thilakasiri - E/16/367

% Contents:- Dequantization

function [dequant] = deQuantization(resized_img, method, Q)

    % Dequantization
    size(resized_img)
    
    if method == 1 
        % There is no dequantization for Level Quantized arrays
        % This is just normalizing values
        dequant = (resized_img/1000);
    else
        % Dequantization
        Q_div = repmat(Q,50)
        dequant = resized_img.*Q_div;
        dequant = dequant/1000;
        figure; imshow(dequant); title('Dequantized Image - E/16/367');
    end
end