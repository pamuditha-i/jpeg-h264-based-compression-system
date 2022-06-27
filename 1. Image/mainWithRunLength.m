% L.B.I.P Thilakasiri - E/16/367

% Main file for Image - [Compression, Transmission & Reconstruction]
% Contents:
% 1. Reading the Image and GrayScale Conversion
% 2. Division of 8x8 Blocks
% 3. Discrete Cosine Transform 
% 4. Quantization
% 5. Run Length Coding 
% 6. Huffman Coding 
% 7. Huffman Decoding
% 8. Run Length Decoding 
% 9. Re-merging Blocks and Output


clear all;
close all;
clc;

% Reading the Image and COnverting to GrayScale
ori_img = imread('rose.jpg');
ori_gray_img = rgb2gray(ori_img); %converted into gray scaled image
ori_gray_img = im2double(ori_gray_img); 
figure; imshow(ori_img); title('Original Image - E/16/367');
figure; imshow(ori_gray_img); title('Original Image in GrayScale - E/16/367');
figure; imhist(ori_gray_img); title('Image Color Histogram - E/16/367');

% Dividing the Image to 8x8 blocks
blocked = blkproc(ori_gray_img,[8 8],'dct2'); % dct2 => 2D DCT
figure; imshow(blocked); title('DCT Image - E/16/367');

size(blocked)

% Quantization
% Requesting Level of Quantization
method = (input('Requested Quantization Method => Level Quantization (1), JPEG Matrix (2) ? '));

if method == 1
    Q = (input('Requested Quantization Level ? '));
    % The Resultant Valules from DCT are in 0.00x Range
    % Therefore, the Vector is Scaled by 1000 and Rounded Up
    blocked = blocked.*(1000);
    
    quantized = blocked./(255/Q);
    quantized = round(quantized);
    quantized = (quantized.*(255/Q));
    figure; imshow(uint8(quantized)); title('Quantized Image - E/16/367');

elseif method == 2
    level = (input('Requested Quantization Matrix => Q10 (1), Q50 (2), Q90 (3) ? '));
    % The Resultant Valules from DCT are in 0.00x Range
    % Therefore, the Vector is Scaled by 1000 and Rounded Up
    blocked = blocked.*(1000);
    if level == 1                       % Q10
        Q = [80 60 50 80 120 200 255 255; 
            55 60 70 95 130 255 255 255; 
            70 65 80 120 200 255 255 255;
            70 85 110 145 255 255 255 255;
            90 110 185 255 255 255 255 255;
            120 175 255  255 255 255 255 255;
            245 255 255 255 255 255 255 255;
            255 255 255 255 255 255 255 255];
        
        Q_div = repmat(Q,50)
        quantized = blocked./Q_div;
        quantized = ceil(quantized);
        
    elseif level == 2                   % Q50
        Q = [16 11 10 16 24 40 51 61;
       12 12 14 19 26 58 60 55;
       14 13 16 24 40 57 69 56;
       14 17 22 29 51 87 80 62;
       18 22 37 56 68 109 103 77;
       24 35 55 64 81 104 113 92;
       49 64 78 87 103 121 120 101;
       72 92 95 98 112 100 103 99];
   
        Q_div = repmat(Q,50)
        quantized = blocked./Q_div;
        quantized = ceil(quantized);
   
    elseif level == 3                   % Q90
        Q = [3 2 2 3 5 8 10 12;
    2 2 3 4 5 12 12 11;
    3 3 3 5 8 11 14 11;
    3 3 4 6 10 17 16 12;
    4 4 7 11 14 22 21 15;
    5 7 11 13 16 12 23 18;
    10 13 16 17 21 24 24 21;
    14 18 19 20 22 20 20 20];

        Q_div = repmat(Q,50)
        quantized = blocked./Q_div;
        quantized = ceil(quantized);

    else
        disp('Invalid Input!')
    end

    figure; imshow(quantized); title('Quantized Image - E/16/367');

else
     disp('Invalid Input!')
end


Q

% Run Length Encoding
[arr, len] = run_length_coding(quantized(:));

% Finding Probabilities
[g, ~, intensity_val] = grp2idx(arr(:));
freq = accumarray(g, 1);
symbol_list = intensity_val';
[intensity_val freq];
prob = freq./(len);
len = length(prob);
t = table(intensity_val, freq, prob) % table(element, count, prob); 

% Huffman Coding
huff_dict = huffmandict(intensity_val,prob);
encoded_gray_img = huffmanenco(arr(:),huff_dict);

% Huffman Decoding
decoded_gray_img = huffmandeco(encoded_gray_img,huff_dict);

% Run Length Decoding
resized_img = run_length_decoding(decoded_gray_img);

figure; imshow(resized_img); title('Huffman Decoded Image - E/16/367');

% Inverse DCT
size(resized_img)
if method == 1
    dequant = (resized_img/1000);
    %figure; imshow((dequant)); title('Dequantized Image - E/16/367');
    inverse_dct_blocked = blkproc(dequant,[8 8],'idct2'); 
    figure; imshow((inverse_dct_blocked)); title('Reconstructed Image - E/16/367');
    figure; imhist(inverse_dct_blocked); title('Reconstructed Image Color Histogram - E/16/367');
else
    dequant = resized_img.*Q_div;
    dequant = dequant/1000;
    figure; imshow(dequant); title('Dequantized Image - E/16/367');
    inverse_dct_blocked = blkproc(dequant,[8 8],'idct2');
    figure; imshow((inverse_dct_blocked)); title('Reconstructed Image - E/16/367');
    figure; imhist(inverse_dct_blocked); title('Reconstructed Image Color Histogram - E/16/367');
end