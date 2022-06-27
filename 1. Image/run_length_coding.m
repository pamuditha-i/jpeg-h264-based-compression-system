% L.B.I.P Thilakasiri - E/16/367

% Contents:- Run Length Coding

function [arr, len] = run_length_coding(init)

% Gets the Quantized Array as the Input and 
% Returns the Run Length Encoded [400,400] Matrix
% [400,400] is the Image Size

    init = reshape(init,[1,160000]);
    outp = [];
    count = 1;
    
    % Counting the Occurences
    for i = 1:length(init)-1
        if(init(i) == init(i+1))
            count = count + 1;
        else
            outp = [outp,init(i),count,];
        count = 1;
        end
    end
    
    outp = [outp,init(length(init)),count];
    len = length(outp);
    arr = outp;
end