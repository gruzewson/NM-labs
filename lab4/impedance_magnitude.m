function impedance_delta = impedance_magnitude(omega)

if omega <= 0
    msg = "wrong value for omega";
    error(msg);
end
R = 525;
C = 7 * 1e-5;
L = 3;
M = 75; % docelowa wartość modułu impedancji

denominator = 1/R^2 + (omega*C - 1/(omega*L))^2
Z = 1/sqrt(denominator);
Z = abs(Z);

impedance_delta = Z - M;

end
