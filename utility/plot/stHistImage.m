function [img, fhandle] = stHistImage(X, plotFlag, fhandle)
% Create an intensity histogram from the (x,y) data in columns of X
%
%    [img, figHandle] = stHistImage(X, [plotFlag = true], fhandle)
%
% X:  An N x 2 matrix of the scatter plot values.  These are divided into
%     32 bins at the moment.  
%     We need to add arguments to set the number and values of the histogram edges
%
% pair of param/val arguments might be
%    edge1    vector
%    edge2    vector
%    showPlot (true/false)
%
% BW, Copyright Imageval Consulting, LLC, 2015

%% Check parameters
if notDefined('X'),    error('X required');
elseif size(X,2) ~= 2, error('X size is wrong');
end
if notDefined('plotFlag'), plotFlag = true; end
if notDefined('fhandle'),  fhandle = []; end

%% Calls external function histcn to form the image

% Do the calculation
[img, ~, mid] = histcn(X);
% vcNewGraphWin; plot(X(:,1),X(:,2),'.'); axis equal; identityLine;

%% We will allow more parameters here
if plotFlag
    if isempty(fhandle), fhandle = vcNewGraphWin; 
    else,                figure(fhandle)
    end
    
    imagesc(mid{1:2},img);
    axis xy; colormap(0.4 + 0.6*gray(256)); colorbar
end

end


