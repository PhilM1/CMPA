%PA 8
clear;
close all;

Is = 0.01e-12; %Amps
Ib = 0.1e-12; %Amps
Vb = 1.3; %Volts
Gp = 0.1; %1/Ohm

%PART 1 ----------------

I = @(x) Is*(exp(1.2*x/0.025)-1)+ Gp * x - Ib*exp(-1.2/0.025*(x+Vb));

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
%A is Is, B is Gp , C is Ib, D is Vb,

%2 PARAMS: A, C
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + Gp.*x - C*(exp(1.2*(-(x+Vb))/25e-3)-1)');
ff = fit(transpose(VArray),transpose(IArray),fo);
If = ff(VArray);
fig5 = figure(5);
plot(VArray, transpose(If), 'LineWidth', 2);

%3 PARAMS: A, B, C
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+Vb))/25e-3)-1)');
ff = fit(transpose(VArray),transpose(IArray),fo);
If = ff(VArray);
hold on; 
plot(VArray, transpose(If), 'LineWidth', 2);

%4 PARAMS: A, B, C, D
fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff = fit(transpose(VArray),transpose(IArray),fo);
If = ff(VArray);
hold on;
plot(VArray, transpose(If), 'LineWidth', 2);
legend('2 Params', '3 Params', '4 Params');
title('Curve fitting using fit()');
xlabel('Voltage (V)');
ylabel('Current (A)');

%PART 4 -----------------

fig6 = figure(6);
inputs = VArray.';
targets = IArray.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net);
Inn = outputs;
plot(VArray, outputs);