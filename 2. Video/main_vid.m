% % L.B.I.P Thilakasiri - E/16/367
% 
% % Main file for Video - [Compression, Transmission & Reconstruction]
% 
% % Contents:
% % 01. Reading the Frames and GrayScale Conversion
% % 02. Choosing the Previous Frame as Reference
% % 03. Division of 8x8 Blocks of the Previous Frame
% % 04. Discrete Cosine Transform of the Previous Frame
% % 05. Quantization of the Previous Frame
% % 06. Huffman Coding of the Previous Frame
% % 07. Huffman Decoding of the Previous Frame
% % 08. Dequantization of the Previous Frame & Re-merging Blocks 
% % 09. Store the Predicted Lossy Ref Frame Based on Original Previous Frame
% % 10. Motion Estimation - Motion Vectors and Block Matching
% % 11. Transmission
% % 12. Recreating the Frames using the MV, Ref and Residues
% 
clc;
clear all;
close all;

% Reading two Consecutive Frames & Varible Defenition

block_size = 8; % Block Size
no_frames = 2; % Number of Frames
frame_list = cell(1,10);
gray_list = cell(1,10);
inverse_dct_blocked = cell(1,10);
recon = cell(1,10);

for i = 1:10
    
    frame_list{1,i} = imread(sprintf('f1_%d.jpg',i));
    gray_list{1,i} = rgb2gray(frame_list{1,i});
    gray_list{1,i} = im2double(gray_list{1,i});
    
    % DCT, Entropy Coding, Decoding and IDCT of the Intra Frames
    inverse_dct_blocked{1,i} = img_transmission_process(gray_list{1,i});
    
    % Motion Estimation
    if i == 1
        recon{1,i} = inverse_dct_blocked{1,i};
    else
        [recon{1,i}, compensated] = motion_estimation(inverse_dct_blocked{1,i-1}, gray_list{1,i}, block_size);
        figure; subplot(3,1,1); imhist(gray_list{1,i}); title(sprintf('Original Gray Frame'));
                subplot(3,1,2); imhist(recon{1,i}); title(sprintf('Reconstructed Frame'));
                subplot(3,1,3); imhist(compensated);  title(sprintf('Compensated Frame'));
                suptitle(sprintf('Histogram Comparison of Frame 0%d - E/16/367', i));            
    end
end

