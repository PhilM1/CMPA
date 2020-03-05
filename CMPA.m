%PA 8
clear;
close all;

Is = 0.01e-12; %Amps
Ib = 0.1e-12; %Amps
Vb = 1.3; %Volts
Gp = 0.1; %1/Ohm

%PART 1 ----------------

I = @(x) Is*(exp(1.2*x/0.025)-1)+ Gp * x + Ib*exp(-1.2/0.25*(x+Vb));

VArray = linspace(-1.95,0.7,200);
IArray = I(VArray);
randomMultiplierArray = -.2 + (0.4).* rand(200,1);
randomMultiplierArray = transpose(randomMultiplierArray);
IArray_Random = IArray + IArray.*randomMultiplierArray;

fig1 = figure(1);
plot(VArray, IArray);
hold on;
plot(VArray, IArray_Random);
legend('I', 'Irnd');
xlabel('Voltage (V)');
ylabel('Current (A)');
title('Part 1 - Current vs Voltage');

fig2 = figure(2);
semilogy(VArray,IArray);
hold on;
semilogy(VArray, IArray_Random);
legend('I', 'Irnd');
xlabel('Voltage (V)');
ylabel('Current (V)');
title('Part 1 - Current vs Voltage (Log Scale)');

%PART 2 ----------------
