function main4_4
    

    a = 1;
    b = 50;
    ytolerance = 1e-12;
    max_iterations = 100;

    [omega_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @impedance_magnitude);
    [omega_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @impedance_magnitude);

    figure;
    subplot(2,1,1);
    plot(1:length(xtab_bisection), xtab_bisection);
    hold on;
    plot(1:length(xtab_secant), xtab_secant);
    xlabel('iterations');
    ylabel('omega');
    title('Iterations vs Omega');
    legend('Bisection Method', 'Secant Method');
    grid on;

    subplot(2,1,2);
    semilogy(1:length(xdif_bisection), xdif_bisection);
    hold on;
    semilogy(1:length(xdif_secant), xdif_secant);
    xlabel('iterations');
    ylabel('xdif');
    title('Iterations vs Delta Omega');
    legend('Bisection Method', 'Secant Method');
    grid on;
    print -dpng zadanie4.png 

    function impedance_delta = impedance_magnitude(omega)
        if omega <= 0
            error("wrong value for omega");
        end
        R = 525;
        C = 7 * 1e-5;
        L = 3;
        M = 75;

        denominator = 1/R^2 + (omega*C - 1/(omega*L))^2;
        Z = 1/sqrt(denominator);
        impedance_delta = abs(Z) - M;
    end

    function [xsolution, ysolution, iterations, xtab, xdif] = bisection_method(a, b, max_iterations, ytolerance, fun)
        xsolution = [];
        ysolution = [];
        iterations = [];
        xtab = [];
        xdif = [];

        for iterations = 1:max_iterations
            xsolution = (a + b) / 2;
            xtab = [xtab; xsolution];

            if iterations > 2
                xdif = [xdif; abs(xtab(iterations) - xtab(iterations-1))];
            end

            if abs(fun(xsolution)) < ytolerance
                break;
            elseif fun(a) * fun(xsolution) < 0
                b = xsolution;
            else
                a = xsolution;
            end
        end

        ysolution = fun(xsolution);
    end

    function [xsolution, ysolution, iterations, xtab, xdif] = secant_method(a, b, max_iterations, ytolerance, fun)
        xsolution = [];
        ysolution = [];
        iterations = [];
        xtab = [];
        xdif = [];

        for iterations = 1:max_iterations
            xsolution = b - (fun(b)*(b - a))/(fun(b) - fun(a));
            xtab = [xtab; xsolution];
            if iterations > 1
                xdif = [xdif; abs(xtab(iterations) - xtab(iterations-1))];
            end

            if abs(fun(xsolution)) < ytolerance
                break;
            end
            a = b;
            b = xsolution;
        end

        ysolution = fun(xsolution);
    end
end
