options = optimset('Display', 'iter');
fzero(@tan, 6, options);
options = optimset('Display', 'iter');
fzero(@tan, 4.5, options)