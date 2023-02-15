% Copyright 2017 Google Inc.
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     https://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

% Objective:
%   compute the function
%   E(x) = 1/(2sigma^2)||Hx-y||_2^2 + 0.5*lambda*x'*(x-denoise(x))
%
% Inputs:
%   y - the input image
%   x_est - the recovered image
%   input_sigma - noise level
%   ForwardFunc - the degradation operator H
%   lambda - regularization parameter
%   effective_sigma - the input noise level to the denoiser
%
% Output:
%   fun_val - the value of E(x_est)

function fun_val = CostFunc(y, x_est, ForwardFunc, input_sigma,...
    lambda,beta, effective_sigma)


nSig=100;
Par=ParSet(nSig);
f_est1 = Denoiser3(x_est);
f_est2 = Denoiser(x_est, effective_sigma);
%f_est2 = Denoiser4(x_est);

fun_val1 = sum(sum((ForwardFunc(x_est)-y).^2))/(2*input_sigma^2);
fun_val2 = lambda*sum(sum(x_est.*(x_est-f_est1)));
fun_val3 = beta*sum(sum(x_est.*(x_est-f_est2)));

fun_val = fun_val1 + fun_val2 + fun_val3;
%fun_val = fun_val1 + fun_val2;
return;

