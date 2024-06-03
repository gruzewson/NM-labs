function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
% Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
%   - nmax = length(y_yearly)-1
%   - y_approximation{1,i} stanowi aproksymację stopnia i
%   - y_approximation{1,i} stanowi wartości funkcji aproksymującej w punktach x_fine
% mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
%   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
% msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
%   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
%   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine

country = 'Poland';
source = 'Solar';
degrees = [1, 2, 3, 4];

x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = [];
mse = zeros(length(degrees), 1);

if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end - 12 * n_years + 1:end);
    y4sum = reshape(y_cut, [12, n_years]);
    y_yearly = sum(y4sum, 1)';

    % Przygotowanie wektorów x_coarse i x_fine
    N = length(y_yearly);
    P = (N - 1) * 10 + 1;
    x_coarse = linspace(-1, 1, N)';
    x_fine = linspace(-1, 1, P)';

    % Inicjalizacja zmiennych na podstawie N
    y_approximation = cell(1, N - 1);
    mse = zeros(N - 1, 1);
    msek = zeros(N - 2, 1);

    for i = 1:N-1
        % Wyznaczanie współczynników wielomianu aproksymującego za pomocą my_polyfit
        p = my_polyfit(x_coarse, y_yearly, i);
        % Wyznaczanie wartości aproksymowanej funkcji w x_fine
        y_approximation{i} = polyval(p, x_fine);
        % Obliczanie błędu średniokwadratowego w x_coarse
        y_approx = polyval(p, x_coarse);
        mse(i) = mean((y_yearly - y_approx).^2);
    end

    for i = 1:N-2
        msek(i) = mean((y_approximation{i} - y_approximation{i + 1}).^2);
    end

    figure;
    % Pierwszy wykres: oryginalne dane roczne i wybrane aproksymacje
    subplot(3, 1, 1);
    plot(x_coarse, y_yearly, 'k', 'DisplayName', 'Dane roczne');
    hold on;
    colors = ['r', 'g', 'b', 'm'];
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{degrees(i)}, colors(i), 'DisplayName', ['Stopień ', num2str(degrees(i))]);
    end
    hold off;
    xlabel('x');
    ylabel('Produkcja energii (TWh)');
    title(['Aproksymacja rocznych danych - ', country, ', ', source]);
    legend show;

    % Drugi wykres: wartości błędów średniokwadratowych w funkcji stopnia wielomianu
    subplot(3, 1, 2);
    semilogy(1:N-1, mse, '-o');
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy (MSE)');
    title('Błąd średniokwadratowy aproksymacji');

    % Trzeci wykres: wartości błędu różnicowego w funkcji stopnia wielomianu
    subplot(3, 1, 3);
    semilogy(1:N-2, msek, '-o');
    xlabel('Stopień wielomianu');
    ylabel('Błąd różnicowy (MSE)');
    title('Błąd różnicowy aproksymacji');

    saveas(gcf, 'zadanie4.png');
else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end
end

function p = my_polyfit(x, y, deg)
% Implementacja własnej funkcji polyfit
% deg - stopień wielomianu

% Budowanie macierzy Vandermonde'a
X = ones(length(x), deg + 1);
for i = 1:deg
    X(:, i) = x.^(deg + 1 - i);
end

% Rozwiązanie układu równań metodą najmniejszych kwadratów
p = (X' * X) \ (X' * y);

end