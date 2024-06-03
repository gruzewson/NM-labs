function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = zeros(1, 1000);
    for i = 1:1000
        original_Runge(:, i) = 1 / (1 + 25 * x_fine(i)^2);
    end

    subplot(2,1,1);
    plot(x_fine, original_Runge);
    xlabel('x');
    ylabel('Runge Function');
    title('Original and Interpolated Runge Functions');
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i));
        interpolation_nodes = linspace(-1, 1, N(i));
        Runge = 1 ./ (1 + 25 * interpolation_nodes.^2);
        c_runge = V{i} \ Runge';
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_Runge{i});
        hold on;
    end
    legend('Original', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
    hold off

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    plot(x_fine, original_sine);
    xlabel('x');
    ylabel('Sine Function');
    title('Original and Interpolated Sine Functions');
    hold on;
    for i = 1:length(N)
        interpolation_nodes = linspace(-1, 1, N(i));
        sine = sin(2 * pi * interpolation_nodes);
        c_runge = V{i} \ sine';
        interpolated_sine{i} = polyval(flipud(c_runge), x_fine);
        plot(x_fine, interpolated_sine{i});
        hold on;
    end
    legend('Original', 'N = 4', 'N = 8', 'N = 12', 'N = 16');
    hold off

    print -dpng zadanie1.png 

end

function V = vandermonde_matrix(N)
    x_coarse = linspace(-1,1,N);
    V = zeros(N);
    for i = 1:N
        V(:,i) = x_coarse.^(i-1);
    end
end
