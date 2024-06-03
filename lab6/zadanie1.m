function [country, source, degrees, y_original, y_approximation, mse] = zadanie1(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.

country = 'Poland';
source = 'Solar';
degrees = [1, 5, 10, 20];

if isfield(energy, country) && isfield(energy.(country), source)
    y_original = energy.(country).(source).EnergyProduction;
    dates = energy.(country).(source).Dates;

    x = linspace(-1, 1, length(y_original))';

    y_approximation = cell(1, length(degrees));
    mse = zeros(1, length(degrees));

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        degree = degrees(i);
        % Wyznaczanie współczynników wielomianu aproksymującego
        p = polyfit(x, y_original, degree);
        % Wyznaczanie wartości aproksymowanej funkcji
        y_approximation{i} = polyval(p, x);
        % Obliczanie błędu średniokwadratowego
        mse(i) = mean((y_original - y_approximation{i}).^2);
    end

    figure;
    subplot(2, 1, 1);
    plot(dates, y_original, 'k', 'DisplayName', 'Oryginalne dane');
    hold on;
    colors = ['r', 'g', 'b', 'm'];
    for i = 1:length(degrees)
        plot(dates, y_approximation{i}, colors(i), 'DisplayName', ['Stopień ', num2str(degrees(i))]);
    end
    hold off;
    xlabel('Data');
    ylabel('Produkcja energii (TWh)');
    title(['Aproksymacja produkcji energii - ', country, ', ', source]);
    legend show;

    subplot(2, 1, 2);
    bar(mse);
    set(gca, 'XTickLabel', degrees, 'XTick', 1:length(degrees));
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy (MSE)');
    title('Błąd średniokwadratowy aproksymacji');

    saveas(gcf, 'zadanie1.png');
else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end
