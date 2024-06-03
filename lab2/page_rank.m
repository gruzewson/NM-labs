function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 193589;
L1 = 8; %mod(L1, 7) + 1
L2 = 5;
N = 8;
d = 0.85;
Edges = [ 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5 ,6, 6, 6, 7, 8;
          6, 4, 4, 5, 3, 5, 6, 7, 6, 5, 6, 4, 7, 4, 8, 6, 2];
I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
L = 1 ./ sum(B, 1)';
A = spdiags(L, 0, N, N);
b = ((1 - d)/N) * ones(8, 1);
M = I - d * B * A;
r = M \ b;

end