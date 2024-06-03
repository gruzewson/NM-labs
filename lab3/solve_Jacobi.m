function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu
index_number = 193589;
L1 = 9;
[A,b] = generate_matrix(N, L1);
U = triu(A, 1); %above kth diagonal of A
L = tril(A, -1); %below kth diagonal of A
D = diag(diag(A));
M = -(D)\(L+U);
bm = D\b;
x = ones(N,1);
iterations = 0;
tic
while(true) 
    x = M*x + bm;
    err_norm = norm(A*x-b);
    if(iterations >= N || err_norm < 1e-5)
        break;
    end
    iterations = iterations + 1;
end

time = toc;
end
