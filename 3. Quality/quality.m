% L.B.I.P Thilakasiri - E/16/367

% Contents:- 
% Calculation of MSE, PSNR & SSIM Values for Original & Reconstructed Images

clear all;
close all;
clc;

% Variables 
% The Corresponding Images are in the 3. Quality Folder
img_list = cell(1,8);
mse = cell(1,8);
peaksnr = cell(1,8);
d_psnr = cell(1,8);
ssimval = cell(1,8);
d_ssim = cell(1,8);
file_sizes = [10.0, 14.6, 15.6, 16.8, 17.2, 17.9, 18.1, 18.2]; % in kilobytes
ori = imread('ori.jpg');

img_list{1,1} = imread('compressed_Q_1.jpg');
img_list{1,2} = imread('compressed_Q_2.jpg');
img_list{1,3} = imread('compressed_Q_3.jpg');
img_list{1,4} = imread('compressed_Q_4.jpg');
img_list{1,5} = imread('compressed_Q_5.jpg');
img_list{1,6} = imread('compressed_Q_8.jpg');
img_list{1,7} = imread('compressed_Q_16.jpg');
img_list{1,8} = imread('compressed_Q_20.jpg');

for i = 1:8
    
    mse{1,i} = immse(img_list{1,i},ori);
    peaksnr{1,i} = psnr(img_list{1,i},ori);
    d_psnr{1,i} = 1/peaksnr{1,i};
    ssimval{1,i} = ssim(img_list{1,i},ori);
    d_ssim{1,i} = 1/ssimval{1,i};
    
end  

mse
peaksnr
d_psnr
ssimval
d_ssim

figure
p = plot(file_sizes,cell2mat(mse),'-o','LineWidth',3); title('Rate vs MSE - E/16/367'); 
p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
p.MarkerEdgeColor = [1 0.5 0];
xlim([9.5 18.5])
ylim([0 50.5])
xlabel('Rate (kB/s)') 
ylabel('Distortion (MSE)')

figure
p = plot(file_sizes,cell2mat(d_psnr),'-o','LineWidth',3); title('Rate vs 1/PSNR - E/16/367'); 
p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
p.MarkerEdgeColor = [1 0.5 0];
xlim([9.5 18.5])
ylim([0.0200 0.033])
xlabel('Rate (kB/s)') 
ylabel('Distortion (1/PSNR)') 

figure
p = plot(file_sizes,cell2mat(d_ssim),'-o','LineWidth',3); title('Rate vs 1/SSIM - E/16/367'); 
p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
p.MarkerEdgeColor = [1 0.5 0];
xlim([9.5 18.5])
ylim([1 1.18])
xlabel('Rate (kB/s)') 
ylabel('Distortion (1/SSIM)') 
