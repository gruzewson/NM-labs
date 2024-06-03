

a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;

[time_bisection, ~, ~, xtab_bisection, xdif_bisection] = bisection_method(a, b, max_iterations, ytolerance, @rocket_velocity);
[time_secant, ~, ~, xtab_secant, xdif_secant] = secant_method(a, b, max_iterations, ytolerance, @rocket_velocity);


figure;
subplot(2,1,1);
plot(1:length(xtab_bisection), xtab_bisection);
hold on;
plot(1:length(xtab_secant), xtab_secant);
xlabel('iterations');
ylabel('time');
title('Iterations vs Time');
legend('Bisection Method', 'Secant Method');
grid on;

subplot(2,1,2);
semilogy(1:length(xdif_bisection), xdif_bisection);
hold on;
semilogy(1:length(xdif_secant), xdif_secant);
xlabel('iterations');
ylabel('difference');
title('Iterations vs Difference');
legend('Bisection Method', 'Secant Method');
grid on;

print -dpng zadanie6.png 


function velocity_delta = rocket_velocity(t)
    M = 750; % [m/s]
    g = 1.622;
    m0=150000;
    u=2000;
    q=2700;
    if t <= 0
        error("Time can't be <= 0")
    end
    v = u * (log(m0 / (m0 - q*t))) - (g*t)
    velocity_delta = v - M
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
