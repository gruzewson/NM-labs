function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    V = vandermonde_matrix(N);
    nodes_norm = linspace(-1,1,N);
    %interpolation_nodes = linspace(-1, 1, N);
    original_Runge = runge_func(x_fine);
    original_Runge = original_Runge';

    runge_norm = runge_func(nodes_norm);
    c_runge_norm = V \ runge_norm;
    interpolated_Runge = polyval(flipud(c_runge_norm), x_fine);

     nodes_Chebyshev = get_Chebyshev_nodes(N);
     V2 = vandermonde_matrix2(N, nodes_Chebyshev);
     runge_chebyshev = runge_func(nodes_Chebyshev);
     c_runge_chebyshev = V2 \ runge_chebyshev;
     interpolated_Runge_Chebyshev = polyval(flipud(c_runge_chebyshev), x_fine);

     figure;

    subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Runge function');
    hold on;
    plot(nodes_norm, runge_norm, 'o', 'DisplayName', 'Runge function at nodes');
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolation for N = 16');
    hold off;
    xlabel('x');
    ylabel('Runge(x)');
    title('Interpolacja dla Runge func');
    legend;
    
    % Wykres dla węzłów Czebyszewa
    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Runge function Chebyshev');
    hold on;
    plot(nodes_Chebyshev, runge_chebyshev, 'o', 'DisplayName', 'Runge function at Chebyshev nodes');
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolation for N = 16');
    hold off;
    title('Interpolacja dla węzłów Czebyszewa');
    xlabel('x');
    ylabel('Runge(x)');
    legend;

    print -dpng zadanie2.png 

end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    for k = 0:N-1
        nodes(k+1) = cos(k * pi/(N - 1));
    end
end

function V = vandermonde_matrix(N)
    x_coarse = linspace(-1,1,N);
    V = zeros(N);
    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end

function V2 = vandermonde_matrix2(N, nodes_Chebyshev)
    V2 = zeros(N);
    for i = 1:N
        V2(:,i) = nodes_Chebyshev.^(i-1);
    end
end

function runge = runge_func(x)
    runge = (1 ./ (1 + 25 * x.^2))';
end
