clear
close all
clc
%% Leer Archivo
signal = load('./Mediciones/mediciones5.txt');

t = linspace(0,60,length(signal));
length(t)

%% Señal Sin Filtrar
figure()
plot(t,signal,'Color',[.6,.1,.6], LineWidth=1.5)
axis([0 4 1.5 5.5 ]);
title('Señal ECG')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
grid on


%% Filtros Digitales

fs = 100; %Frecuencia de muestreo
fc = 60; %Frecuencia de corte

n = 9;
Wn = fc/fs; %Fc normalizada

[b,a] = butter(n,Wn,'low');
[h1,w1] = freqz(b,a); %Respuesta de Frecuencia

figure()
f = [0 0.6 0.6 1];
m = [1 1 0 0];
plot(f,m,w1/pi,abs(h1))
title('Filtro 60 Hz')
xlabel('\omega/ \pi')
legend({'Ideal','Filtro'})

signal_f = filter(b,a,signal);

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

figure()
plot(t,signal_f,'b','LineWidth',1.5)
axis([0 4 1.5 5 ]);
title('Señal ECG Filtrada')
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')

%% FIR
n = 11;
f = [0 0.4 0.4 1];
m = [1 1 0 0];

b1 = fir2(n,f,m);

signal_f2 = filter(b1,1,signal_f);

figure()
plot(t,signal_f2,'Color',[0,0,.5],'LineWidth',1.5)
axis([0 4 2 4.5]);
xlabel('Tiempo [s]')
ylabel('Amplitud [Volts]')
title('Señal ECG Filtrada')
grid on

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

[h1,w1] = freqz(b1,1);
figure()
plot(f,m,w1/pi,abs(h1))
title('Filtro 40 Hz')
xlabel('\omega/ \pi')
legend({'Ideal','fir2'})

%% BPM


[amp, pos] = findpeaks(signal_f2, 'MinPeakProminence',.8);
findpeaks(signal_f2,'MinPeakProminence',.8);
title('Picos prominentes');
xlabel('Tiempo');
ylabel('Amplitud');
ylim([2 4.5]);

distance = [];

for i=1:length(pos)-1
    dif = abs(pos(i+1,1) - pos(i,1));
    distance(i,1) = dif;
end


BPM_dist = mean(distance);


if (BPM_dist >= 60) && (BPM_dist  <= 100)
    disp('Ritmo cardiaco normal')
elseif (BPM_dist  < 60)
    disp('Posible Braquicardia')
else
    disp('Posible Taquicardia')
end

