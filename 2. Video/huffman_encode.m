% L.B.I.P Thilakasiri - E/16/367

% Contents:- Huffman Encoding

function [huff_dict, encoded_gray_img] = huffman_encode(quantized)

    % Finding Probabilities
    [g, ~, intensity_val] = grp2idx(quantized(:));
    freq = accumarray(g, 1);
    prob = freq./(400*400);
    t = table(intensity_val, freq, prob) % table(element, count, prob); 

    % Huffman Coding
    huff_dict = huffmandict(intensity_val,prob);
    encoded_gray_img = huffmanenco(quantized(:),huff_dict);
end