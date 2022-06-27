% L.B.I.P Thilakasiri - E/16/367

% Contents:- Huffman Decoding

function [resized_img] = huffman_decode(huff_dict, encoded_gray_img)

    % Huffman Decoding
    decoded_gray_img = huffmandeco(encoded_gray_img,huff_dict);
    resized_img = reshape(decoded_gray_img,[400 400]); 
end