load('filtr_dielektryczny.mat')
%direct
    index_number = 193589;
    L1 = 9;
    tic
    x = A\b;
    time_direct = toc;
    err_norm_direct = norm(A*x-b)

%jacobs
    index_number = 193589;
    L1 = 9;
    N = 100;
    U = triu(A, 1); %above kth diagonal of A
    L = tril(A, -1); %below kth diagonal of A
    D = diag(diag(A));
    M = -(D)\(L+U);
    bm = D\b;
    x = ones(length(b),1);
    iterations = 0;
    tic
    while(true) 
        x = M*x + bm;
        err_norm_jacob = norm(A*x-b);
        if(iterations >= N || err_norm_jacob < 1e-5)
            break;
        end
        iterations = iterations + 1;
    end
    err_norm_jacob
    time = toc;

    index_number = 193589;
    L1 = 9;
    N = 100;
    U = triu(A, 1); %above kth diagonal of A
    L = tril(A, -1); %below kth diagonal of A
    D = diag(diag(A));
    M = -(D + L)\U;
    bm = (D+L)\b;
    x = ones(length(b),1);
    iterations = 0;
    tic
    while(true) 
        x = M*x + bm;
        err_norm_gauss = norm(A*x-b);
        if(iterations >= N || err_norm_gauss < 1e-5)
            break;
        end
        iterations = iterations + 1;
    end
    time = toc;
    err_norm_gauss  
   
