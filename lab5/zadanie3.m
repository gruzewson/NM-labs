function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
    % Zwracane są trzy wektory wierszowe:
    % matrix_condition_numbers - współczynniki uwarunkowania badanych macierzy Vandermonde
    % max_coefficients_difference_1 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera wartości funkcji liniowej
    % max_coefficients_difference_2 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
    %       gdy b zawiera zaburzone wartości funkcji liniowej

    N = 5:40;

    %% chart 1
    matrix_condition_numbers = zeros(1, length(N));

    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        matrix_condition_numbers(i) = cond(V);
    end

    %% chart 2
    a1 = randi([20,30]);
    max_coefficients_difference_1 = zeros(1, length(N));

    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        b = linspace(0,a1,ni)';
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ];

        calculated_coefficients = V \ b;

        max_coefficients_difference_1(i) = max(abs(calculated_coefficients-reference_coefficients));
    end

    %% chart 3
    max_coefficients_difference_2 = zeros(1, length(N));

    for i = 1:length(N)
        ni = N(i);
        V = vandermonde_matrix(ni);
        b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
        reference_coefficients = [ 0; a1; zeros(ni-2,1) ];

        calculated_coefficients = V \ b;

        max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
    end
    
    figure;
    
    % Wykres 1
    subplot(3,1,1);
    semilogy(N, matrix_condition_numbers);
    title('Wzrost współczynnika uwarunkowania macierzy Vandermonde');
    xlabel('N');
    ylabel('Współczynnik uwarunkowania');
    grid on;
    
    % Wykres 2
    subplot(3,1,2);
    plot(N, max_coefficients_difference_1);
    title('Błąd wyznaczenia współczynników dla wartości funkcji');
    xlabel('N');
    ylabel('Max błąd');
    grid on;
    
    % Wykres 3
    subplot(3,1,3);
    plot(N, max_coefficients_difference_2);
    title('Błąd wyznaczenia współczynników dla zaburzonych wartości funkcji');
    xlabel('N');
    ylabel('Max błąd');
    grid on;
    print -dpng zadanie3.png 
end

function V = vandermonde_matrix(N)
    x = linspace(0, 1, N);
    V = [];
    for i = 1:N
        V(:,i) = x.^(i-1);
    end
end
