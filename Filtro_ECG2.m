% Eliminamos los datos guardados en memoria y la consola
clear
close all
clc
%% Leer Archivo
signal = load('./Mediciones/mediciones5.txt');
% Creamos una variable t, de 0 - 60, con longitud de datos de la señal
t = linspace(0,60,length(signal));

%% Grafica de la señal Sin Filtrar
figure()
plot(t,signal,'Color',[.6,.1,.6], LineWidth=1.5)
axis([0 4 1.5 5.5 ]);
title('Señal ECG')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
grid on

%% Filtro Digital IIR

fs = 100; %Frecuencia de muestreo
fc = 60; %Frecuencia de corte

n = 9; % orden del filtro
Wn = fc/fs; %Fc normalizada

[b,a] = butter(n,Wn,'low'); % Elegimos el filtro
[h1,w1] = freqz(b,a); %Respuesta de Frecuencia

% Grafica de la respuesta del filtro
figure()
f = [0 0.6 0.6 1];
m = [1 1 0 0];
plot(f,m,w1/pi,abs(h1))
title('Filtro 60 Hz')
xlabel('\omega/ \pi')
legend({'Ideal','Filtro'})

% Filtramos la señal
signal_f = filter(b,a,signal);

% Grafica comparativa de la señal original y la señal filtrada
figure()
subplot(211)
plot(t,signal)
ylim([2 5.2])
title('Señal ECG')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
subplot(212)
plot(t,signal_f)
ylim([1.5 5])
title('Señal ECG Filtrada')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')

% Grafica de una ventana de 4 segundos de la señal filtrada
figure()
plot(t,signal_f,'b','LineWidth',1.5)
axis([0 4 1.5 5 ]);
title('Señal ECG Filtrada')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')

%% Filtro Digital FIR

n = 11; % Orden del filtro
f = [0 0.4 0.4 1]; % Frequency breakpoints
m = [1 1 0 0]; % Magnitude breakpoints

b1 = fir2(n,f,m); % Frequency sampling-based FIR filter design

signal_f2 = filter(b1,1,signal_f); % Señal filtrada

% Ventana de la señal con los 2 filtros
figure()
plot(t,signal_f2,'Color',[0,0,.5],'LineWidth',1.5)
axis([0 4 2 4.5]);
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
title('Señal ECG Filtrada')
grid on

% Grafico comparativo del la señal con 1 filtro y con 2 filtros
figure()
subplot(211)
plot(t,signal_f)
ylim([1 5.2])
title('Señal ECG Filtro 1')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
subplot(212)
plot(t,signal_f2)
ylim([1.5 5])
title('Señal ECG Filtro 2')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')

% Grafico de la respuesta del filtro
[h1,w1] = freqz(b1,1); % Respuesta del filtro
figure()
plot(f,m,w1/pi,abs(h1))
title('Filtro 40 Hz')
xlabel('\omega/ \pi')
legend({'Ideal','fir2'})

%% BPM

% Obtenemos los picos prominentes
[amp, pos] = findpeaks(signal_f2, 'MinPeakProminence',.8);
findpeaks(signal_f2,'MinPeakProminence',.8);
title('Picos prominentes');
xlabel('Tiempo');
ylabel('Amplitud');
ylim([2 4.5]);

% Obtenemos la frecuencia cardiaca
distance = [];
for i=1:length(pos)-1
    dif = abs(pos(i+1,1) - pos(i,1));
    distance(i,1) = dif;
end
BPM_dist = mean(distance);

% Comparamos la frecuencia cardiaca con las mediciones tipicas
if (BPM_dist >= 60) && (BPM_dist  <= 100)
    disp('Ritmo cardiaco normal')
elseif (BPM_dist  < 60)
    disp('Posible Braquicardia')
else
    disp('Posible Taquicardia')
end

