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
%Fitting
fit4 = polyfit(VArray, IArray, 4);
fit4rnd = polyfit(VArray, IArray_Random, 4);
fit8 = polyfit(VArray, IArray, 8);
fit8rnd = polyfit(VArray, IArray_Random, 8);
%fig3 = figure(3);
figure(1);
plot(VArray, polyval(fit4, VArray),'LineWidth', 2);
hold on;
plot(VArray, polyval(fit4rnd, VArray),'LineWidth', 2);
plot(VArray, polyval(fit8, VArray),'LineWidth', 2);
plot(VArray, polyval(fit8rnd, VArray),'LineWidth', 2);
legend('I', 'Irnd', 'IFit4', 'IrndFit4', 'IFit8', 'IrndFit8');

%swap to log
%set(gca, 'YScale', 'log');

%PART 3 ----------------



