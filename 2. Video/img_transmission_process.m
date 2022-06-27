% L.B.I.P Thilakasiri - E/16/367

% Contents:- Image Transmission Procedure
% 01. DCT 
% 02. Quantization
% 03. Huffman Coding at the transmitting End
% 04. Hufman DecodiNg at the Receiving End
% 05. Inverse DCT

function [inverse_dct_blocked] = img_transmission_process(gray_f)
    blocked = blkproc(gray_f,[8 8],'dct2'); % dct2 => 2D DCT
    % The Resultant Valules are in 0.00x Range
    % Therefore, Scaled by 1000 and Rounded Up
    blocked = (blocked.*1000);
    [quantized, method, Q] = Quantization(blocked); % Quantization
    [huff_dict, encoded_gray_img] = huffman_encode(quantized); % Image Compression
    resized_img = huffman_decode(huff_dict, encoded_gray_img); % Image Decompression
    dequant = deQuantization(resized_img, method, Q); % Dequantization
    inverse_dct_blocked = blkproc(dequant,[8 8],'idct2'); % IDCT Transform
    
    figure; imshow(inverse_dct_blocked); title('Predicted Lossy Intra Frame Based on Original Frame - E/16/367');
    %figure; imhist(inverse_dct_blocked); title('Reconstructed Image Color Histogram - E/16/367');
end
