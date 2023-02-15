function y_est=Denoiser3(x_est)
sigma= 4;   % the noise level assumed in the non-local denoiser
input=x_est/255;




if length(size(input))>2
    input=rgb2gray(input);
end

[NA, y_est] = BM3D(1, input, sigma);

y_est=y_est*255;

return 