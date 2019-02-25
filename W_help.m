function out = W_help(k,a,b,c)
    s = tf('s');
    if a ~= inf
        out = k* ((s/a) + c)/((s/b) + 1);
    else
        out = k* c/((s/b) + 1);
    end
end